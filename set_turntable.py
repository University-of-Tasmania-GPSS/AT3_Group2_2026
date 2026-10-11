r"""Set Plotly 3D views to turntable in the notebook and existing Explorer export.

Run from the project root: python .\set_turntable.py .
No spatial data are read or recomputed. Existing files get a one-time backup.
"""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path

DRAG_MODE = re.compile(
    r'''(?P<prefix>["']?(?:scene\.)?dragmode["']?\s*:\s*)(?P<quote>["'])orbit(?P=quote)'''
)


def update_source(source: str) -> tuple[str, int, int]:
    updated, rotations = DRAG_MODE.subn(
        lambda m: m['prefix'] + m['quote'] + 'turntable' + m['quote'], source
    )
    hints = updated.count('Drag to orbit')
    updated = updated.replace('Drag to orbit', 'Drag to rotate (turntable)')
    return updated, rotations, hints


def prepare(path: Path) -> tuple[bytes, int, int]:
    original = path.read_bytes()
    encoding = 'utf-8-sig' if original.startswith(b'\xef\xbb\xbf') else 'utf-8'
    source = original.decode(encoding)
    if path.suffix == '.ipynb':
        notebook = json.loads(source)
        rotations = hints = 0
        for cell in notebook.get('cells', []):
            if cell.get('cell_type') != 'code':
                continue
            lines = cell.get('source', [])
            text = ''.join(lines) if isinstance(lines, list) else lines
            updated, n_modes, n_hints = update_source(text)
            rotations += n_modes
            hints += n_hints
            if n_modes or n_hints:
                cell['source'] = updated.splitlines(keepends=True) if isinstance(lines, list) else updated
        if not (rotations or hints):
            return original, 0, 0
        updated = json.dumps(notebook, ensure_ascii=False, indent=1) + '\n'
    else:
        updated, rotations, hints = update_source(source)
    return updated.encode(encoding), rotations, hints


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('project', nargs='?', default='.', type=Path)
    parser.add_argument('--notebook', type=Path, help='Specific notebook if the project has multiple copies.')
    parser.add_argument('--dry-run', action='store_true')
    args = parser.parse_args()
    root = args.project.resolve()
    if not (root / 'myst.yml').is_file():
        parser.error('Use the project root: the folder containing myst.yml.')
    excluded = {'_build', '.git', 'node_modules', '.ipynb_checkpoints', 'backups', 'archive'}
    if args.notebook:
        notebook = args.notebook if args.notebook.is_absolute() else root / args.notebook
        if not notebook.is_file():
            parser.error(f'Notebook not found: {notebook}')
        notebooks = [notebook]
    else:
        notebooks = [p for p in root.rglob('09_Interactive_Map.ipynb')
                     if not any(part.lower() in excluded for part in p.relative_to(root).parts)]
        if len(notebooks) > 1:
            parser.error('Multiple notebook copies found. Choose one with --notebook "path/to/09_Interactive_Map.ipynb".')
    explorer = root / 'Output_Data' / 'processed' / 'interactive_map_data' / 'explorer'
    data_folders = {'vendor', 'data', 'rasters'}
    exports = [p for p in explorer.rglob('*')
               if p.is_file() and p.suffix.lower() in {'.js', '.html'}
               and not data_folders.intersection(p.relative_to(explorer).parts)] if explorer.is_dir() else []
    files = notebooks + exports
    if not files:
        parser.error('No map notebook or exported Explorer found in this project.')
    # Prepare every change before writing, so malformed input cannot cause a partial patch.
    changes = []
    for path in files:
        updated, rotations, hints = prepare(path)
        if rotations or hints:
            changes.append((path, updated, rotations, hints))
    if not changes:
        print('No orbital defaults found. No files changed.')
        return
    for path, updated, rotations, hints in changes:
        if not args.dry_run:
            backup = path.with_name(path.name + '.turntable.bak')
            if not backup.exists():
                backup.write_bytes(path.read_bytes())
            path.write_bytes(updated)
        try:
            name = path.relative_to(root)
        except ValueError:
            name = path
        print(f'{"Would update" if args.dry_run else "Updated"} {name}: '
              f'{rotations} rotation default(s), {hints} control hint(s).')
    if not args.dry_run:
        print('Done. Restart Jupyter Book, then refresh the Explorer. No data rebuild is needed.')
        if not notebooks:
            print('No notebook was found; only the existing export was updated.')
        if not exports:
            print('No existing export was found. Re-export the map from the patched notebook when ready.')


if __name__ == '__main__':
    main()
