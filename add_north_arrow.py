"""Add a north arrow to the Heard Island explorer's 2D maps."""
import argparse
import json
import re
from pathlib import Path

MARKER = "// Heard Island north arrow: north-up 2D maps."
NORTH_ARROW = r"""// Heard Island north arrow: north-up 2D maps.
const northArrow = L.control({position: 'topright'});
northArrow.onAdd = () => {
  const arrow = L.DomUtil.create('div', 'hi-north-arrow');
  arrow.setAttribute('role', 'img');
  arrow.setAttribute('aria-label', 'North');
  arrow.title = 'North';
  arrow.style.cssText = 'width:44px;height:70px;padding:4px;box-sizing:border-box;' +
    'background:rgba(11,20,32,.88);border:1px solid #40576a;border-radius:7px;' +
    'box-shadow:0 2px 8px #0005;pointer-events:none;';
  arrow.innerHTML = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 60" ' +
    'width="100%" height="100%" aria-hidden="true" focusable="false">' +
    '<text x="20" y="14" text-anchor="middle" fill="#e8eff5" ' +
    'font-family="system-ui,sans-serif" font-size="14" font-weight="750">N</text>' +
    '<path d="M20 20 L34 54 L20 45 L6 54 Z" fill="#e8eff5" ' +
    'stroke="#e8eff5" stroke-width="1.2" stroke-linejoin="round"/>' +
    '<path d="M20 20 L20 45 L6 54 Z" fill="#69d5ff"/>' +
    '<path d="M20 20 L20 45" fill="none" stroke="#0b1420" stroke-width="1"/>' +
    '</svg>';
  return arrow;
};
northArrow.addTo(this.map);"""
SCALE = re.compile(
    r"(?m)^(?P<indent>[ \t]*)L\.control\.scale\([^\n]*\)\.addTo\(this\.map\);[ \t]*$")


def add_arrow(source):
    if MARKER in source:
        return source, False
    matches = list(SCALE.finditer(source))
    if len(matches) != 1:
        raise ValueError(
            "Expected one shared Leaflet scale-control line; found "
            f"{len(matches)}. No files have been changed.")
    match = matches[0]
    block = "\n".join(match["indent"] + line for line in NORTH_ARROW.splitlines())
    return source[:match.end()] + "\n" + block + source[match.end():], True


def backup_and_write(path, content):
    backup = path.with_name(path.name + ".north-arrow.bak")
    if not backup.exists():
        backup.write_bytes(path.read_bytes())
    path.write_text(content, encoding="utf-8")
    print(f"Updated: {path}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("project", nargs="?", default=".",
                        help="Project folder containing myst.yml.")
    parser.add_argument("--notebook",
                        help="Notebook path, relative to the project or absolute.")
    args = parser.parse_args()
    project = Path(args.project).resolve()
    if not (project / "myst.yml").is_file():
        parser.error("Run from the book project folder, or pass that folder as an argument.")
    notebook = project / (args.notebook or "09_Interactive_Map.ipynb")
    if not notebook.is_file():
        parser.error("Cannot find 09_Interactive_Map.ipynb. Use --notebook PATH if it has moved.")

    original = notebook.read_text(encoding="utf-8")
    data = json.loads(original)
    cells = [cell for cell in data["cells"]
             if cell.get("cell_type") == "code" and
             re.search(r"(?m)^APP_JS\s*=", "".join(cell.get("source", [])))]
    if len(cells) != 1:
        parser.error(f"Expected one APP_JS cell; found {len(cells)}.")
    cell = cells[0]
    source = "".join(cell["source"])
    updated, changed = add_arrow(source)
    planned = []
    if changed:
        cell["source"] = updated.splitlines(keepends=True)
        indent_match = re.search(r'\n( +)"cells"\s*:', original)
        indent = len(indent_match[1]) if indent_match else 1
        planned.append((notebook, json.dumps(data, indent=indent, ensure_ascii=False) + "\n"))

    exported = project / "Output_Data/processed/interactive_map_data/explorer/assets/explorer.js"
    export_changed = False
    if exported.is_file():
        updated_export, export_changed = add_arrow(exported.read_text(encoding="utf-8"))
        if export_changed:
            planned.append((exported, updated_export))

    for path, content in planned:
        backup_and_write(path, content)
    if not planned:
        print("North arrow already present; no changes needed.")
    if not exported.is_file():
        print("No exported explorer.js found. Run the APP_JS cell, then the export cell.")
    else:
        print("Notebook and exported map are ready. Restart the book and hard-refresh the page.")
    print("Commit the changed notebook and explorer.js to deploy the arrow online.")


if __name__ == "__main__":
    main()

