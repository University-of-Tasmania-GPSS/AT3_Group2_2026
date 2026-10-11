// Figure zoom for this book, using MyST's anywidget interface and GLightbox.
// Community inspiration: https://github.com/choldgraf/myst-lightbox.
// See THIRD_PARTY_NOTICES.md for the bundled GLightbox licence.
let pathMod, urlMod;
try {
  pathMod = await import('node:path');
  urlMod = await import('node:url');
} catch { /* Browser: only render() is used. */ }
const pluginPath = urlMod?.fileURLToPath(import.meta.url);
const linkClass = 'myst-lightbox-link';
const cssURL = new URL('./design-assets/glightbox.min.css', import.meta.url).href;
const jsURL = new URL('./design-assets/glightbox.min.js', import.meta.url).href;

function loadAssets() {
  if (window.__heardFigureZoomAssets) return window.__heardFigureZoomAssets;
  window.__heardFigureZoomAssets = Promise.all([
    new Promise((resolve, reject) => {
      const link = document.createElement('link');
      link.rel = 'stylesheet'; link.href = cssURL;
      link.onload = resolve; link.onerror = reject;
      document.head.appendChild(link);
    }),
    new Promise((resolve, reject) => {
      if (window.GLightbox) { resolve(); return; }
      const script = document.createElement('script');
      script.src = jsURL;
      script.onload = resolve; script.onerror = reject;
      document.head.appendChild(script);
    }),
  ]).catch(error => {
    delete window.__heardFigureZoomAssets;
    throw error;
  });
  return window.__heardFigureZoomAssets;
}

async function render({ el }) {
  el.style.display = 'none';
  const article = el.closest('article') || document.querySelector('article.article');
  if (!article) return;
  try { await loadAssets(); }
  catch { console.warn('Figure zoom assets could not load; figures remain visible.'); return; }
  if (!el.isConnected) return;
  const addedLinks = [];
  let gallery;
  const prepareFigures = () => {
    let added = false;
    article.querySelectorAll('figure img').forEach(img => {
      if (img.closest('a[href]') || !img.getAttribute('src')) return;
      const anchor = document.createElement('a');
      anchor.className = linkClass;
      anchor.href = img.src;
      anchor.setAttribute('aria-label', 'Enlarge figure: ' + (img.alt || 'image'));
      anchor.dataset.glightbox = 'type: image';
      const caption = img.closest('figure')?.querySelector('figcaption');
      if (caption) anchor.dataset.description = caption.innerHTML;
      img.parentNode.insertBefore(anchor, img);
      anchor.appendChild(img);
      addedLinks.push(anchor);
      added = true;
    });
    if (added && gallery) gallery.reload();
  };
  prepareFigures();
  gallery = window.GLightbox({ selector: `.${linkClass}`, loop: true, zoomable: true });
  const observer = new MutationObserver(prepareFigures);
  observer.observe(article, { childList: true, subtree: true });
  return () => {
    observer.disconnect();
    gallery.destroy();
    addedLinks.forEach(anchor => {
      if (anchor.isConnected) anchor.replaceWith(...anchor.childNodes);
    });
  };
}

const inject = {
  name: 'heard-figure-zoom',
  doc: 'Adds local, keyboard-accessible figure zoom without changing numbering.',
  stage: 'document',
  plugin: (_, utils) => (tree, file) => {
    if (!utils.selectAll('container[kind="figure"]', tree).length) return;
    tree.children.push({
      type: 'block',
      children: [{
        type: 'anywidget',
        esm: pathMod.relative(pathMod.dirname(file.path), pluginPath),
        model: {},
        id: crypto.randomUUID(),
      }],
    });
  },
};
export default { name: 'Heard Island figure zoom', transforms: [inject], render };
