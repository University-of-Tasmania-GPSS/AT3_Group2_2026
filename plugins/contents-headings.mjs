// Keep clickable dropdown titles in MyST's native document outline.
const sectionLabels = new Set([
  'methods-geology', 'methods-surface-terrain', 'methods-velocity',
  'methods-solar', 'methods-synthesis',
  'results-low-elevation', 'results-geology', 'results-exposure',
  'results-lagoon', 'results-lagoon-bed', 'results-summary',
  'discussion-synthesis', 'discussion-climate', 'discussion-future',
  'conclusion-workflow', 'conclusion-close',
]);
const sectionTitles = new Set(['Scope of the evidence', 'Read or explore']);
const plainText = node => node.value ?? (node.children ?? []).map(plainText).join('');

const headings = {
  name: 'dropdown-title-headings',
  doc: 'Makes closed dropdown summaries real headings without duplicating the title.',
  stage: 'document',
  plugin: (_, utils) => (tree, file) => {
    const page = file.path.replace(/\\/g, '/').split('/').pop().replace(/\.[^.]+$/, '');
    const used = new Set([
      ...utils.selectAll('[identifier]', tree).map(node => node.identifier),
      ...utils.selectAll('[html_id]', tree).map(node => node.html_id),
    ]);
    const newId = text => {
      const titleSlug = text.toLowerCase().replace(/['’]/g, '')
        .replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '') || 'section';
      const base = `${page}-fold-${titleSlug}`;
      let id = base, suffix = 2;
      while (used.has(id)) id = `${base}-${suffix++}`;
      used.add(id);
      return id;
    };
    for (const details of utils.selectAll('details', tree)) {
      const summary = details.children?.[0];
      if (summary?.type !== 'summary' || summary.children?.[0]?.type === 'heading') continue;
      const heading = {
        type: 'heading',
        depth: sectionLabels.has(details.label) || sectionTitles.has(plainText(summary)) ? 2 : 3,
        children: summary.children,
        class: 'dropdown-title-heading',
      };
      for (const key of ['label', 'identifier', 'html_id']) {
        if (details[key]) { heading[key] = details[key]; delete details[key]; }
      }
      const id = heading.html_id || heading.identifier || heading.label || newId(plainText(summary));
      heading.label ??= id;
      heading.identifier ??= id;
      heading.html_id ??= id;
      summary.children = [heading];
    }
  },
};
export default { name: 'Contents headings', transforms: [headings] };
