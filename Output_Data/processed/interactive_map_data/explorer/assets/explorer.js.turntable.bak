// LAGOON_CREDIT_AND_CAMPAIGN_ALIAS


/* Heard Island explorer. Local assets are lazy-loaded; no Python is needed after export. */
(() => {
'use strict';
const H = window.HI, D = H.overview, $ = id => document.getElementById(id);
const esc = value => String(value ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const years = [1947,1988,2014,2019,2026];
const colours = D.year_colours;
const focus = ['Brown','Stephenson'];
let toastTimer, island, glacierView = null, currentGlacier = null, terrainState = null, glacierRequest = 0;
function toast(message) { $('toast').textContent = message; $('toast').hidden = false; clearTimeout(toastTimer); toastTimer = setTimeout(() => $('toast').hidden = true, 5500); }
function showError(message) { $('map-message').textContent = message; $('map-message').hidden = false; }
if (!window.L) { showError('Leaflet could not load. Re-run the export with internet access, or connect to load the map library.'); return; }
const scriptPromises = new Map();
function loadScript(path) {
  if (scriptPromises.has(path)) return scriptPromises.get(path);
  const promise = new Promise((resolve,reject) => {
    const script = document.createElement('script'); script.src = path + (path.includes('?') ? '&' : '?') + 'v=' + D.build_id;
    script.onload = resolve; script.onerror = () => { scriptPromises.delete(path); script.remove(); reject(new Error('Could not load ' + path + '. Keep the assets folder beside the HTML.')); };
    document.head.appendChild(script);
  }); scriptPromises.set(path,promise); return promise;
}
function preventMapScroll(element) {
  // Stop propagation, not default behaviour: the panel must still scroll normally.
  L.DomEvent.disableClickPropagation(element); L.DomEvent.disableScrollPropagation(element);
  element.addEventListener('wheel', e => e.stopPropagation(), {passive:true});
  element.addEventListener('touchmove', e => e.stopPropagation(), {passive:true});
}
document.querySelectorAll('.sidebar,.timeline,.credits-content').forEach(preventMapScroll);
function sourceButtons(ids) {
  return (ids || []).map(id => `<button class="text-button source-link" data-source="${esc(id)}">${esc(D.sources[id]?.title || id)} ↗</button>`).join('<br>');
}
function legend(spec) {
  if (!spec) return '';
  let scale = spec.discrete ? spec.colours.map((c,i) => `<div class="legend-category"><span class="swatch" style="background:${c}"></span>${esc(spec.ticks[i])}</div>`).join('') :
    `<div class="legend-gradient" style="background:linear-gradient(to right,${spec.colours.join(',')})"></div><div class="legend-ticks">${spec.ticks.map(t=>`<span>${esc(t)}</span>`).join('')}</div>`;
  return scale + `<p>${esc(spec.note)}</p>`;
}
function vectorLegend(layer) {
  if (layer.id === 'geology') return Object.entries(D.rock_colours).map(([label,colour]) => `<div class="legend-category"><span class="swatch" style="background:${colour}"></span>${esc(label)}</div>`).join('') + '<p>Mapped surface units; Snow/Ice does not identify the substrate beneath ice.</p>';
  if (layer.id.startsWith('ice_')) return '';
  if (layer.id === 'lost_1947_2026') return '<p>Filled area = inside the 1947 outline and outside the 2026 outline. Remaining 2026 ice is excluded.</p><div><span class="swatch" style="background:#ffb36b"></span>Brown</div><div><span class="swatch" style="background:#69d5ff"></span>Stephenson</div>';
  if (layer.id === 'retreat_zones') return ['1947–1988','1988–2014','2014–2019','2019–2026','2026 remaining'].map((label,i)=>`<div class="legend-category"><span class="swatch" style="background:${['#F4DF70','#BE9AFF','#FF83AF','#8FE88C','#E8EFF5'][i]}"></span>${label}</div>`).join('')+'<p>Separate mapped loss intervals, plus ice remaining in 2026. These polygons are context for the geology comparison.</p>';
  if (layer.id === 'coastline') return '<p>Line boundary of the supplied coastline polygon.</p>';
  if (layer.id === 'lagoons') return '<p>Filled lagoon extents from the supplied 2014 polygons; not measured water level.</p>';
  if (layer.id === 'bed_highs') return '<p>Screened modelled bed highs. Retained-trial counts are not confidence probabilities.</p>';
  if (layer.tab === 'Field evidence') return '<p>Survey/archive evidence. Depths are relative to survey water. Dashed geometry marks provisional registration.</p>';
  return '<p>Click features for their recorded attributes.</p>';
}
function outlineStyle(feature, fill = false) {
  const p = feature.properties || {}, year = p.year;
  return {color:colours[year] || '#e8eff5',weight:2.1,opacity:1,fillColor:colours[year] || '#e8eff5',fillOpacity:fill?.22:0,
    dashArray:p.provisional?'2 6':({'1947':'8 4','1988':'5 4','2014':'','2019':'4 3','2026':''}[year] || '')};
}
function styleVector(feature,id) {
  const p = feature.properties || {};
  let colour = D.glacier_colours[p.name_1] || '#D8E3EC';
  if (id === 'retreat_zones') colour = {'1947–1988':'#F4DF70','1988–2014':'#BE9AFF','2014–2019':'#FF83AF','2019–2026':'#8FE88C','2026 remaining':'#E8EFF5'}[p.zone] || colour;
  if (id === 'geology') colour = D.rock_colours[p.Rock_Type || 'Unknown'] || '#BCCBD7';
  if (id === 'lagoons' || id.includes('lagoon')) colour = '#69D5FF';
  if (id === 'coastline') return {color:'#d1ddd9',weight:1.2,opacity:.9,fill:false};
  const provisional = String(p.geometry_status || '').startsWith('provisional');
  return {color:provisional?'#F4DF70':colour,weight:id==='transects'?3:1.5,fillColor:colour,
    fillOpacity:id==='geology'?.55:id==='lost_1947_2026'?.55:.4,opacity:1,
    dashArray:provisional || id==='cross_sections'?'6 4':''};
}
function featureInfo(feature) {
  const p = feature.properties || {};
  let html = '';
  Object.entries(D.tooltip_labels).forEach(([key,label]) => {
    if (p[key] != null) html += `<tr><th>${esc(label)}</th><td>${esc(typeof p[key] === 'number' ? Number(p[key].toFixed(2)) : p[key])}</td></tr>`;
  });
  return html ? '<table>' + html + '</table>' : '';
}

// GEOLOGY_HOVER_LOOKUP
function geologyPolygons(geometry) {
  if (!geometry) return [];
  if (geometry.type === 'Polygon') return [geometry.coordinates];
  if (geometry.type === 'MultiPolygon') return geometry.coordinates;
  if (geometry.type === 'GeometryCollection') return geometry.geometries.flatMap(geologyPolygons);
  return [];
}

// Count horizontal ray crossings; holes are tested separately below.
function geologyRingContains(ring, lon, lat) {
  let crossings = 0;
  for (let edge = 0; edge < ring.length - 1; edge++) {
    const a = ring[edge], b = ring[edge + 1];
    const crosses = (a[1] <= lat && lat < b[1]) || (b[1] <= lat && lat < a[1]);
    if (crosses) {
      const intersection = a[0] + (lat - a[1]) * (b[0] - a[0]) / (b[1] - a[1]);
      if (lon < intersection) crossings++;
    }
  }
  return crossings % 2 === 1;
}

function installGeologyHover(view) {
  const map = view.map, container = map.getContainer();
  const tip = L.tooltip({className: 'geology-hover', direction: 'auto',
    offset: [14, 0], opacity: 1, interactive: false});
  let cachedEntry = null, polygons = [], cursor = null, frame = 0;

  const hide = () => {
    cancelAnimationFrame(frame); frame = 0; cursor = null; tip.remove();
  };
  const update = () => {
    frame = 0;
    const entry = view.active.get('geology');
    if (!entry || !cursor) {hide(); return;}
    // Cache bounding boxes once per displayed geology layer, reducing hover work.
    if (entry !== cachedEntry) {
      cachedEntry = entry; polygons = [];
      for (const feature of entry.layer.data.features || []) {
        for (const rings of geologyPolygons(feature.geometry)) {
          let west = Infinity, east = -Infinity, south = Infinity, north = -Infinity;
          for (const point of rings[0]) {
            west = Math.min(west, point[0]); east = Math.max(east, point[0]);
            south = Math.min(south, point[1]); north = Math.max(north, point[1]);
          }
          polygons.push({feature, rings, west, east, south, north});
        }
      }
    }
    const {lng: lon, lat} = cursor;
    // Prefer the last-drawn feature if the display polygons overlap.
    const found = [...polygons].reverse().find(p =>
      lon >= p.west && lon <= p.east && lat >= p.south && lat <= p.north
      && geologyRingContains(p.rings[0], lon, lat)
      && !p.rings.slice(1).some(hole => geologyRingContains(hole, lon, lat)));
    if (!found) {tip.remove(); return;}
    const properties = found.feature.properties || {};
    const extra = featureInfo({properties: {...properties, Rock_Type: null}});
    tip.setLatLng(cursor).setContent('<strong>'
      + esc(properties.Rock_Type || 'Unit not recorded')
      + '</strong><div class="geology-hover-caption">Mapped rock/deposit type</div>' + extra);
    if (!map.hasLayer(tip)) tip.addTo(map);
  };
  const move = event => {
    if (!view.active.has('geology') || event.buttons
        || event.target.closest('.leaflet-control,.leaflet-popup')) {hide(); return;}
    cursor = map.mouseEventToLatLng(event);
    if (!frame) frame = requestAnimationFrame(update);
  };
  // Capture cursor movement before overlays can consume the event; clicks are untouched.
  container.addEventListener('mousemove', move, {capture: true, passive: true});
  container.addEventListener('mouseleave', hide);
  map.on('movestart', hide);
  map.on('layerremove', event => {
    if (event.layer === cachedEntry?.object) hide();
  });
  // Avoid competing glacier hover cards while geology is enabled; keep name labels.
  map.on('tooltipopen', event => {
    if (view.active.has('geology') && event.tooltip !== tip
        && !event.tooltip.options.permanent) map.closeTooltip(event.tooltip);
  });
  map.on('unload', () => {
    hide(); container.removeEventListener('mousemove', move, true);
    container.removeEventListener('mouseleave', hide);
  });
}

class View {
  constructor(mapId,history,bounds) {
    this.map = L.map(mapId,{zoomControl:true,preferCanvas:true,minZoom:7,maxZoom:18,zoomSnap:.25});
    this.map.createPane('rasterData').style.zIndex = 350;
    this.map.createPane('polygons').style.zIndex = 380;
    this.map.createPane('inventory').style.zIndex = 420;
    this.map.createPane('evidence').style.zIndex = 460;
    this.map.createPane('names').style.zIndex = 490;

    // Let clicks pass through labels and their connecting lines.
    this.map.getPane('names').style.pointerEvents = 'none';
    this.tiles = L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',{
      // Dim imagery inside glacier dashboards so evidence layers remain legible.
      attribution:esc(D.imagery_credit),maxZoom:19,crossOrigin:true,
      opacity:mapId==='glacier-map'?.48:1}).addTo(this.map);
    this.map.attributionControl.setPrefix('<a href="https://leafletjs.com/" target="_blank" rel="noopener">Leaflet</a>');
    L.control.scale({imperial:false,position:'bottomleft',maxWidth:140}).addTo(this.map);
    this.bounds = bounds; this.map.fitBounds(bounds,{padding:[35,35]}); this.history = history;
    this.active = new Map(); this.definitions = new Map(); this.rowContainers = new Set(); this.timeline = null;
    installGeologyHover(this);
  }
  layerObject(layer) {
    if (layer.type === 'raster') return L.imageOverlay(layer.image,layer.bounds,{opacity:.78,pane:'rasterData',interactive:false,alt:layer.title});
    const isIce = layer.id.startsWith('ice_');
    return L.geoJSON(layer.data,{
      pane:isIce?'inventory':(['geology','lagoons','coastline'].includes(layer.id)?'polygons':'evidence'),
      style:f => isIce?outlineStyle(f):styleVector(f,layer.id),
      pointToLayer:(f,ll) => L.circleMarker(ll,{radius:5,pane:'evidence',weight:1.3,fillOpacity:.9,...styleVector(f,layer.id)}),
      onEachFeature:(f,obj) => {
        if (isIce) {
          const p = f.properties;
          obj.bindTooltip(`${esc(p.name_1)} · ${p.year}${p.provisional?' · provisional':''}`);
          obj.on('click',()=>p.RGIId && openGlacier(p.RGIId));
        } else {
          const info = featureInfo(f); if (info) obj.bindPopup(info + sourceButtons(layer.sources),{maxWidth:310});
        }
      }
    });
  }
  add(layer) {
    if (this.active.has(layer.id)) return;
    const object = this.layerObject(layer); object.addTo(this.map); this.active.set(layer.id,{layer,object,opacity:.78}); this.sync();
  }
  remove(id) { const entry = this.active.get(id); if (entry) this.map.removeLayer(entry.object); this.active.delete(id); this.sync(); }
  clear() { for (const id of [...this.active.keys()]) this.remove(id); if(this.timeline)this.timeline.hide(); this.sync(); }
  opacity(id,value) {
    const entry = this.active.get(id); if (!entry) return; entry.opacity = value;
    if (entry.layer.type === 'raster') entry.object.setOpacity(value);
    else entry.object.eachLayer(obj => obj.setStyle && obj.setStyle({opacity:value,fillOpacity:value*.65}));
  }
  sync() {
    for (const container of this.rowContainers) container.querySelectorAll('[data-layer]').forEach(row=>{
      const active = this.active.has(row.dataset.layer), input = row.querySelector('input[type=checkbox]');
      input.checked=active; row.classList.toggle('is-active',active); row.querySelector('.layer-detail').hidden=!active;
      if(active){const percentage=Math.round(this.active.get(row.dataset.layer).opacity*100);row.querySelector('input[type=range]').value=percentage;row.querySelector('output').textContent=percentage+'%';}
    });
    if (this === glacierView) $('active-layer-count').textContent=`${this.active.size} active layer${this.active.size===1?'':'s'}`;
  }
  destroy() { if(this.timeline)this.timeline.destroy(); this.map.remove(); this.active.clear(); this.rowContainers.clear(); }
}
function inventoryLayers(history) {
  return years.filter(year => history.some(f=>f.properties.year===year)).map(year=>({
    id:'ice_'+year,title:`${year} inventory`,tab:'Retreat',type:'vector',
    year,data:{type:'FeatureCollection',features:history.filter(f=>f.properties.year===year)},sources:D.inventory_sources[year] || []
  }));
}
function renderLayerRows(container,layers,view,grouped=false) {
  container.replaceChildren(); view.rowContainers.add(container);
  if (!layers.length) { container.innerHTML='<p class="empty-note">No saved spatial layer is available for this section.</p>'; return; }
  const groups = grouped ? [...new Set(layers.map(l=>l.tab))] : [''];
  for(const group of groups) {
    const subset = grouped?layers.filter(l=>l.tab===group):layers;
    let holder = container;
    if(grouped) { holder = document.createElement('details'); holder.className='layer-group'; holder.open=group==='Retreat'; holder.innerHTML=`<summary>${esc(group==='Overview'?'Context':group)} <span class="muted">· ${subset.length}</span></summary>`; container.append(holder); }
    subset.forEach(layer=>{
      view.definitions.set(layer.id,layer);
      const row = document.createElement('div'); row.className='layer-row'; row.dataset.layer=layer.id;
      const swatch=layer.year?`<span class="line-swatch" style="border-color:${colours[layer.year]}"></span>`:'';
      row.innerHTML=`<div class="layer-label"><label class="layer-label layer-name"><input type="checkbox" aria-label="${esc(layer.title)}">${swatch}<span>${esc(layer.title)}</span></label><button class="info-button" title="Layer references" aria-label="Sources for ${esc(layer.title)}">i</button></div><div class="layer-detail" hidden>${layer.type==='raster'?legend(layer.style):vectorLegend(layer)}<div class="opacity-label"><span>Opacity</span><output>78%</output></div><input type="range" min="0" max="100" value="78" aria-label="${esc(layer.title)} opacity"><button class="text-button layer-source">References ↗</button></div>`;
      row.querySelector('input[type=checkbox]').addEventListener('change',e=> e.target.checked?view.add(layer):view.remove(layer.id));
      row.querySelector('input[type=range]').addEventListener('input',e=>{ row.querySelector('output').textContent=e.target.value+'%'; view.opacity(layer.id,Number(e.target.value)/100); });
      row.querySelectorAll('.info-button,.layer-source').forEach(b=>b.addEventListener('click',()=>openCredits(layer.sources,layer)));
      holder.append(row);
    });
  } view.sync();
}
class Timeline {
  constructor(container,view) {
    this.container=container;this.view=view;this.index=2;this.visible=false;this.playing=false;this.timer=null;this.overlay=null;
    this.collapsed=false;
    const bodyId=container.id+'-controls';
    container.innerHTML='<div class="timeline-head"><span class="timeline-title">GLACIER RETREAT · MAPPED DATES</span><span class="timeline-compact-date" hidden>No date shown</span><button class="text-button timeline-collapse" aria-expanded="true" aria-controls="'+bodyId+'" aria-label="Collapse animation controls">Collapse ▾</button></div><div id="'+bodyId+'" class="timeline-body"><div class="timeline-tools"><button class="text-button timeline-toggle">Show date</button></div><div class="timeline-main"><button class="play">▶ Play</button><input type="range" min="0" max="4" value="2" step="1" aria-label="Inventory date"><output class="timeline-year">2014</output></div><div class="timeline-dates">'+years.map(y=>`<span>${y}</span>`).join('')+'</div><div class="timeline-status">Step through mapped dates; intervals are not equally spaced in time.</div></div>';
    container.querySelector('.play').onclick=()=>this.playing?this.pause():this.play();
    container.querySelector('input').oninput=e=>{this.pause();this.index=Number(e.target.value);this.show();};
    container.querySelector('.timeline-toggle').onclick=()=>this.visible?this.hide():this.show();
    container.querySelector('.timeline-collapse').onclick=()=>this.setCollapsed(!this.collapsed);
  }
  setCollapsed(collapsed) {
    // Collapse pauses playback but preserves the selected footprint on the map.
    if(collapsed)this.pause();
    this.collapsed=collapsed;this.container.classList.toggle('is-collapsed',collapsed);
    this.container.querySelector('.timeline-body').hidden=collapsed;
    this.container.querySelector('.timeline-compact-date').hidden=!collapsed;
    const button=this.container.querySelector('.timeline-collapse');
    button.textContent=collapsed?'Expand ▴':'Collapse ▾';
    button.setAttribute('aria-expanded',String(!collapsed));
    button.setAttribute('aria-label',collapsed?'Expand animation controls':'Collapse animation controls');
    if(this.view===island)requestAnimationFrame(layoutIslandLabels);
  }
  show() {
    this.visible=true;
    // A single animated date replaces selected static inventory layers, avoiding ambiguous overlaps.
    for(const id of [...this.view.active.keys()])if(id.startsWith('ice_'))this.view.remove(id);
    if(this.overlay)this.view.map.removeLayer(this.overlay);
    const year=years[this.index], features=this.view.history.filter(f=>f.properties.year===year);
    this.overlay=L.geoJSON({type:'FeatureCollection',features},{pane:'inventory',interactive:false,style:f=>outlineStyle(f,true)}).addTo(this.view.map);
    this.container.querySelector('.timeline-toggle').textContent='Hide date';
    this.container.querySelector('.timeline-year').textContent=year;
    this.container.querySelector('.timeline-compact-date').textContent=String(year);
    this.container.querySelector('input').value=this.index;
    const provisional=features.some(f=>f.properties.provisional);
    this.container.querySelector('.timeline-status').textContent=!features.length?'No saved outline for this date.':provisional?'Includes provisional recent outlines · dotted boundaries.':year===1947?'1947 is nominal; some records pre-date this year.':'Mapped inventory · equal screen time, unequal real intervals.';
  }
  hide() {this.pause();this.visible=false;if(this.overlay)this.view.map.removeLayer(this.overlay);this.overlay=null;this.container.querySelector('.timeline-toggle').textContent='Show date';this.container.querySelector('.timeline-compact-date').textContent='No date shown';}
  play() {if(!this.visible)this.index=0;this.playing=true;this.container.querySelector('.play').textContent='Ⅱ Pause';this.show();this.timer=setInterval(()=>{this.index=(this.index+1)%years.length;this.show();},1350);}
  pause() {clearInterval(this.timer);this.timer=null;this.playing=false;this.container.querySelector('.play').textContent='▶ Play';}
  destroy(){this.hide();this.container.replaceChildren();}
}
// Island map and the all-glacier inventory controls.
island=new View('island-map',D.history,D.bounds);island.timeline=new Timeline($('island-timeline'),island);
const selection=L.geoJSON({type:'FeatureCollection',features:D.history.filter(f=>f.properties.year===2014 && f.properties.RGIId)},{
  pane:'inventory',style:f=>({color:D.glacier_colours[f.properties.name_1]||'#d6e4ec',weight:1,opacity:.5,fillOpacity:.025}),
  onEachFeature:(f,layer)=>{
    layer.bindTooltip(`<div class="glacier-tip"><strong>${esc(f.properties.name_1)}</strong><span>Open glacier dashboard ↗</span></div>`,{sticky:true});
    layer.on('click',()=>openGlacier(f.properties.RGIId));
    layer.on('mouseover',()=>layer.setStyle({weight:2,fillOpacity:.12}));
    layer.on('mouseout',()=>layer.setStyle({weight:1,fillOpacity:.025}));
  }
}).addTo(island.map);
const nameLabels=L.layerGroup().addTo(island.map);
const nameLabelEntries=[];
D.glaciers.forEach(g=>{
  // Use a point within the glacier footprint, rather than its buffered bounding box.
  const anchor=g.label_anchor?L.latLng(g.label_anchor):L.latLngBounds(g.bounds).getCenter();
  const name=String(g.name||'').trim()||g.id;
  const marker=L.marker(anchor,{interactive:false,icon:L.divIcon({className:'',html:'',iconSize:[0,0]}),pane:'names'})
    .bindTooltip(esc(name),{permanent:true,direction:'center',className:'glacier-name-label',pane:'names'}).addTo(nameLabels);
  const leader=L.polyline([],{pane:'names',interactive:false,color:'#b3c5d3',weight:1,opacity:.65}).addTo(nameLabels);
  nameLabelEntries.push({marker,leader,anchor,focus:g.focus});
  const option=document.createElement('option');option.value=g.id;option.textContent=name; $('glacier-select').append(option);
});
function layoutIslandLabels(){
  // Keep all available names; move colliding labels and connect them to their glacier.
  const map=island.map,size=map.getSize(),mapRect=map.getContainer().getBoundingClientRect();
  const used=[];
  for(const element of map.getContainer().parentElement.querySelectorAll('.map-label,.timeline')){
    const r=element.getBoundingClientRect();
    if(r.width&&r.height)used.push({left:r.left-mapRect.left-6,right:r.right-mapRect.left+6,top:r.top-mapRect.top-6,bottom:r.bottom-mapRect.top+6});
  }
  const overlap=(a,b)=>Math.max(0,Math.min(a.right,b.right)-Math.max(a.left,b.left))*Math.max(0,Math.min(a.bottom,b.bottom)-Math.max(a.top,b.top));
  const candidates=[[0,0]];
  for(const radius of [25,50,80,115,155,200])for(let i=0;i<16;i++){
    const angle=i*Math.PI/8;candidates.push([radius*Math.cos(angle),radius*Math.sin(angle)]);
  }
  for(const entry of [...nameLabelEntries].sort((a,b)=>Number(b.focus)-Number(a.focus))){
    const label=entry.marker.getTooltip().getElement();if(!label)continue;
    const anchor=map.latLngToContainerPoint(entry.anchor);
    const onScreen=anchor.x>=0&&anchor.y>=0&&anchor.x<=size.x&&anchor.y<=size.y;
    label.style.visibility=onScreen?'visible':'hidden';entry.leader.setLatLngs([]);if(!onScreen)continue;
    const width=label.offsetWidth+8,height=label.offsetHeight+6;let best=null;
    for(const [dx,dy] of candidates){
      const x=Math.max(width/2+8,Math.min(size.x-width/2-8,anchor.x+dx));
      const y=Math.max(height/2+8,Math.min(size.y-height/2-8,anchor.y+dy));
      const box={left:x-width/2,right:x+width/2,top:y-height/2,bottom:y+height/2};
      const cost=used.reduce((n,r)=>n+overlap(box,r),0)*1000+Math.hypot(x-anchor.x,y-anchor.y);
      if(!best||cost<best.cost)best={x,y,box,cost};
      if(cost===0)break;
    }
    used.push(best.box);const position=map.containerPointToLatLng([best.x,best.y]);
    entry.marker.setLatLng(position);
    if(Math.hypot(best.x-anchor.x,best.y-anchor.y)>18)entry.leader.setLatLngs([entry.anchor,position]);
  }
}
island.map.on('moveend zoomend resize',()=>requestAnimationFrame(layoutIslandLabels));
requestAnimationFrame(layoutIslandLabels);
renderLayerRows($('island-layers'),[...inventoryLayers(D.history),...D.layers],island,true);
$('island-clear').onclick=()=>island.clear();
$('island-reset').onclick=()=>island.map.fitBounds(D.bounds,{padding:[35,35]});
$('island-imagery').onchange=e=>e.target.checked?island.tiles.addTo(island.map):island.map.removeLayer(island.tiles);
$('glacier-open').onclick=()=>{if($('glacier-select').value)openGlacier($('glacier-select').value);else $('glacier-select').focus();};
$('glacier-select').onchange=()=>{const g=D.glaciers.find(g=>g.id===$('glacier-select').value);if(g)island.map.fitBounds(g.bounds,{padding:[45,45]});};
document.querySelectorAll('[data-glacier]').forEach(b=>b.onclick=()=>openGlacier(b.dataset.glacier));
function resizeViews(){island.map.invalidateSize();if(glacierView)glacierView.map.invalidateSize();if(terrainState&&window.Plotly&&$('terrain-plot')._fullLayout)Plotly.Plots.resize($('terrain-plot'));}
function syncFullscreenButton(){
  const active=Boolean(document.fullscreenElement||document.webkitFullscreenElement);
  const button=$('fullscreen');button.setAttribute('aria-pressed',String(active));
  const fallback=!document.documentElement.requestFullscreen&&!document.documentElement.webkitRequestFullscreen||document.fullscreenEnabled===false;
  const label=active?'Exit full screen':fallback?'Open map in a full window':'Enter full screen';
  button.title=label;button.setAttribute('aria-label',label);requestAnimationFrame(resizeViews);
}
function openFullWindow(){
  // Embedded notebook policies can deny fullscreen; the exported page remains usable.
  const link=document.createElement('a');link.href=window.location.href;link.target='_blank';link.rel='noopener';
  document.body.append(link);link.click();link.remove();
}
$('fullscreen').onclick=async()=>{
  try{
    if(document.fullscreenElement)await document.exitFullscreen();
    else if(document.webkitFullscreenElement)document.webkitExitFullscreen();
    else if(document.fullscreenEnabled===false)openFullWindow();
    else if(document.documentElement.requestFullscreen)await document.documentElement.requestFullscreen();
    else if(document.documentElement.webkitRequestFullscreen)document.documentElement.webkitRequestFullscreen();
    else openFullWindow();
  }catch(error){openFullWindow();}
};
document.addEventListener('fullscreenchange',syncFullscreenButton);
document.addEventListener('webkitfullscreenchange',syncFullscreenButton);
syncFullscreenButton();

async function openGlacier(id) {
  const definition=D.glaciers.find(g=>g.id===id);if(!definition)return;
  const request=++glacierRequest;toast('Opening '+definition.name+'…');
  try {if(!H.glaciers[id])await loadScript(definition.data);if(request!==glacierRequest)return;
    const data=H.glaciers[id];if(!data)throw new Error('Glacier data did not initialise.');
    if(glacierView){glacierView.destroy();glacierView=null;}
    island.timeline.pause();currentGlacier=id;$('glacier-title').textContent=data.name;
    if(!$('glacier-dialog').open)$('glacier-dialog').showModal();
    glacierView=new View('glacier-map',data.history,data.bounds);
    glacierView.timeline=new Timeline($('glacier-timeline'),glacierView);
    const tabs=$('glacier-tabs');tabs.replaceChildren();
    data.tabs.forEach(tab=>{const button=document.createElement('button');button.textContent=tab;button.setAttribute('role','tab');button.onclick=()=>selectTab(tab);button.dataset.tab=tab;tabs.append(button);});
    selectTab('Overview');
    // The most recent saved boundary is a useful opening context, with status retained.
    const latest=Math.max(...data.history.map(f=>f.properties.year));
    glacierView.add(inventoryLayers(data.history).find(l=>l.year===latest));
    $('glacier-clear').onclick=()=>glacierView.clear();
    $('glacier-3d').onclick=()=>openTerrain(id);
    $('glacier-lagoon').hidden = id !== 'RGI60-19.00023';
    $('glacier-lagoon').onclick = () => openLagoon();

    $('glacier-3d').textContent = '3D ice body';
    $('glacier-3d').disabled = true;
    $('glacier-3d').title = 'Checking modelled ice geometry…';
    (H.terrain[id] ? Promise.resolve() : loadScript(definition.terrain))
      .then(() => {
        if (currentGlacier !== id || glacierRequest !== request) return;
        const available = Boolean(H.terrain[id] && glacierIceModel(H.terrain[id]));
        $('glacier-3d').disabled = !available;
        $('glacier-3d').title = available
          ? 'Explore the modelled ice volume'
          : 'No renderable thickness and bed model is available for this glacier';
      }).catch(() => {
        if (currentGlacier === id && glacierRequest === request) {
          $('glacier-3d').title = 'The modelled ice geometry could not be loaded';
        }
      });
    // Include sources for the dated inventories as well as thematic layers.
    $('glacier-sources').onclick = () => openCredits([
      ...new Set(
        [...data.layers, ...inventoryLayers(data.history)]
          .flatMap(layer => layer.sources || [])
      )
    ]);
    requestAnimationFrame(()=>{glacierView.map.invalidateSize();glacierView.map.fitBounds(data.bounds,{padding:[30,30]});});
    $('toast').hidden=true;
  }catch(error){toast(error.message);}
}
function selectTab(tab){
  const data=H.glaciers[currentGlacier];if(!data||!glacierView)return;
  $('glacier-tabs').querySelectorAll('button').forEach(b=>b.setAttribute('aria-selected',String(b.dataset.tab===tab)));
  $('glacier-notes').innerHTML=data.notes[tab]||'';
  const layers=tab==='Retreat'?[...inventoryLayers(data.history),...data.layers.filter(l=>l.tab===tab)]:data.layers.filter(l=>l.tab===tab);
  renderLayerRows($('glacier-layers'),layers,glacierView);$('glacier-sidebar').scrollTop=0;
}
$('glacier-dialog').addEventListener('close',()=>{glacierRequest++;if(glacierView){glacierView.destroy();glacierView=null;}currentGlacier=null;});

// References panel: bibliography and technical/display methods only.
let creditsFilter = null, creditsLayer = null;

function openCredits(ids = null, layer = null) {
  creditsFilter = ids ? new Set(ids) : null;
  creditsLayer = layer;
  renderCredits();

  if (!$('credits-dialog').open) {
    $('credits-dialog').showModal();
  }
}

// Escape reference text before adding italics and a clickable URL.
function referenceHTML(reference) {
  let citation = esc(reference.citation || reference.title || '');

  for (const part of reference.italic_parts || []) {
    const escapedPart = esc(part);
    citation = citation.replace(escapedPart, `<em>${escapedPart}</em>`);
  }

  const link = reference.url
    ? ` <a href="${esc(reference.url)}"
        target="_blank" rel="noopener">${esc(reference.url)}</a>`
    : '';

  // Show original dataset and digitising credits together.
  const additional = (reference.additional_references || [])
    .map(referenceHTML).join('');
  return `<p class="apa-reference">${citation}${link}</p>${additional}`;
}

function renderCredits() {
  $('credits-context').textContent = creditsLayer
    ? creditsLayer.title
    : creditsFilter
      ? 'References for this view'
      : 'Dataset references';

  // Preserve the connection between each layer and its source references.
  // Resolve aliases before removing duplicate references.
  const selected = Object.values(D.sources)
    .filter(source => !creditsFilter || creditsFilter.has(source.id))
    .map(source => D.sources[source.reference_id] || source);
  const sources = [...new Map(selected.map(source => [source.id, source])).values()]
    .sort((a, b) => String(a.citation || a.title)
      .localeCompare(String(b.citation || b.title)));

  $('credits-list').innerHTML = sources.map(source =>
    `<article class="source-card">
      <h3>${esc(source.title)}</h3>
      ${referenceHTML(source)}
    </article>`
  ).join('');

  $('technical-references').innerHTML = D.technical_references
    .map(reference => referenceHTML(reference)).join('');
}

$('credits-open').onclick = () => openCredits();

$('methods-open').onclick = () => {
  openCredits();
  $('methods-details').open = true;
  $('methods-details').scrollIntoView({block: 'nearest'});
};

document.addEventListener('click', event => {
  const source = event.target.closest('[data-source]');

  if (source) {
    openCredits([source.dataset.source]);
  }

  const close = event.target.closest('[data-close]');

  if (close) {
    $(close.dataset.close).close();
  }
});

// GLACIER_ICE_BODY_EXTENSION
// Build a fixed model where this glacier has both thickness and bed values.
function glacierIceModel(data) {
  if (data._iceBodyModel !== undefined) return data._iceBodyModel;
  const thickness = data.options?.find(option => option.id === 'thickness');
  const reference = data.ice?.['2014'];
  if (!data.available || !thickness || !reference || !data.bed) {
    data._iceBodyModel = null;
    return null;
  }
  const top = [], context = [], supported = [];
  const triangles = [], heights = [];
  for (let r = 0; r < data.y.length; r++) {
    top[r] = []; context[r] = []; supported[r] = [];
    for (let c = 0; c < data.x.length; c++) {
      const h = thickness.values[r][c], bed = data.bed[r][c];
      const valid = reference[r][c] === '1' && Number.isFinite(h)
        && h > 0 && Number.isFinite(bed);
      supported[r][c] = valid;
      top[r][c] = valid ? bed + h : null;
      context[r][c] = reference[r][c] === '1' ? null : data.surface[r][c];
      if (valid) heights.push(bed, bed + h);
    }
  }
  const width = data.x.length;
  const add = points => {
    if (points.every(([r, c]) => supported[r][c])) {
      // Orient upper faces consistently, including descending northings.
      if (data.y[1] < data.y[0]) [points[1], points[2]] = [points[2], points[1]];
      triangles.push(points.map(([r, c]) => r * width + c));
    }
  };
  for (let r = 0; r < data.y.length - 1; r++) {
    for (let c = 0; c < width - 1; c++) {
      add([[r, c], [r, c + 1], [r + 1, c + 1]]);
      add([[r, c], [r + 1, c + 1], [r + 1, c]]);
    }
  }
  data._iceBodyModel = triangles.length
    ? {top, context, triangles, thickness, heights}
    : null;
  return data._iceBodyModel;
}

// Join upper and lower faces with walls along outer edges and data gaps.
// ICE_THICKNESS_EXAGGERATION
function iceThicknessFactor() {
  return terrainState?.id === 'island'
    ? 1 : Number($('terrain-thickness')?.value || 1);
}

// Lift outline sections above exaggerated ice where model values exist.
function enlargedOutlineHeights(line, data, model) {
  return line.surface.map((height, index) => {
    if (!Number.isFinite(height)) return null;
    const c = Math.round((line.x[index] - data.x[0]) / (data.x[1] - data.x[0]));
    const r = Math.round((line.y[index] - data.y[0]) / (data.y[1] - data.y[0]));
    if (model && Number.isFinite(model.top[r]?.[c])) {
      return data.bed[r][c]
        + model.thickness.values[r][c] * iceThicknessFactor() + 14;
    }
    return height + 14;
  });
}

function glacierIceTrace(data, model, mask, option) {
  if (!mask) return null;
  const x = [], y = [], z = [], i = [], j = [], k = [];
  const customdata = [], intensity = [], nodes = new Map(), edges = new Map();
  const spec = option ? option.style : D.elevation_style;
  const palette = ['#627887', ...Array.from({length: 127},
    (_, n) => samplePalette(spec, n / 126))];
  const width = data.x.length;
  const node = index => {
    if (nodes.has(index)) return nodes.get(index);
    const r = Math.floor(index / width), c = index % width;
    const first = x.length, h = model.thickness.values[r][c];
    const value = option ? option.values[r][c] : model.top[r][c];
    const code = Number.isFinite(value)
      ? 1 + Math.round(126 * Math.max(0, Math.min(1,
          (value - spec.limits[0]) / (spec.limits[1] - spec.limits[0]))))
      : 0;
    // Two vertices at each horizontal location preserve modelled thickness.
    x.push(data.x[c], data.x[c]); y.push(data.y[r], data.y[r]);
    z.push(data.bed[r][c] + h * iceThicknessFactor(), data.bed[r][c]);
    intensity.push(code, code); customdata.push([h, model.top[r][c]], [h, data.bed[r][c]]);
    nodes.set(index, first);
    return first;
  };
  const face = (a, b, c) => {i.push(a); j.push(b); k.push(c);};
  for (const triangle of model.triangles) {
    if (!triangle.every(index => mask[Math.floor(index / width)][index % width] === '1')) continue;
    const [a, b, c] = triangle.map(node);
    face(a, b, c); face(a + 1, c + 1, b + 1);
    for (const [u, v] of [[a, b], [b, c], [c, a]]) {
      const key = `${Math.min(u, v)}:${Math.max(u, v)}`;
      if (edges.has(key)) edges.delete(key);
      else edges.set(key, [u, v]);
    }
  }
  for (const [u, v] of edges.values()) {
    face(u, u + 1, v + 1); face(u, v + 1, v);
  }
  if (!i.length) return null;
  return {type: 'mesh3d', name: 'Modelled ice body', x, y, z, i, j, k,
    intensity, customdata, intensitymode: 'vertex',
    colorscale: plotlyScale({colours: palette}), cmin: 0, cmax: 127,
    showscale: false, showlegend: false, opacity: 1, flatshading: false,
    lighting: {ambient: .6, diffuse: .8, specular: .15, roughness: .8},
    hovertemplate: 'Modelled elevation %{customdata[1]:.1f} m<br>Modelled thickness %{customdata[0]:.1f} m<extra>Modelled ice body</extra>'};
}

function glacierBodyTraces() {
  const s = terrainState, data = s.data, model = glacierIceModel(data);
  const option = data.options.find(o => o.id === $('terrain-colour').value);
  const mask = data.ice[years[s.index]], show = $('terrain-ice').checked;
  const context = surfaceTrace(data, model ? model.context : data.surface,
    data.surface.map(row => row.map(() => 0)),
    {limits: [0, 1], colours: ['#334651', '#334651']}, 'Terrain context');
  const traces = [context];
  if (show && model) {
    const body = glacierIceTrace(data, model, mask, option);
    if (body) traces.push(body);
  }
  // Historical outlines may extend beyond available model coverage.
  if (show) {
    const x = [], y = [], z = [];
    (data.lines[years[s.index]] || []).forEach(line => {
      x.push(...line.x, null); y.push(...line.y, null);
      z.push(...enlargedOutlineHeights(line, data, model), null);
    });
    if (x.length) traces.push({type: 'scatter3d', mode: 'lines', x, y, z,
      line: {color: colours[years[s.index]], width: 5}, connectgaps: false,
      showlegend: false, hoverinfo: 'skip', name: 'Mapped inventory boundary'});
  }
  return traces;
}

// Plotly 3D: a real camera and fixed physical terrain with dated footprint overlays.
const terrainCamera={eye:{x:.95,y:-1.12,z:.8},up:{x:0,y:0,z:1}};
function plotlyScale(spec){
  if(spec.discrete){let out=[];const n=spec.colours.length;spec.colours.forEach((c,i)=>{out.push([i/n,c],[(i+1)/n,c]);});return out;}
  return spec.colours.map((c,i)=>[i/(spec.colours.length-1),c]);
}
function surfaceTrace(data,z,values,spec,name,opacity=1){return {
  type:'surface',x:data.x,y:data.y,z,surfacecolor:values,colorscale:plotlyScale(spec),cmin:spec.limits[0],cmax:spec.limits[1],
  showscale:false,connectgaps:false,name,opacity,hovertemplate:'Easting offset %{x:.2f} km<br>Northing offset %{y:.2f} km<br>Elevation %{z:.1f} m<extra>'+esc(name)+'</extra>',
  lighting:{ambient:.7,diffuse:.65,specular:.12,roughness:.9},lightposition:{x:-1000,y:500,z:2000},contours:{z:{show:false}}
};}
function mixColour(a,b,f) {
  const rgb=h=>h.replace('#','').match(/../g).map(v=>parseInt(v,16));
  const aa=rgb(a),bb=rgb(b);return '#'+aa.map((v,i)=>Math.round(v*(1-f)+bb[i]*f).toString(16).padStart(2,'0')).join('');
}
function samplePalette(spec,t){
  if(spec.discrete)return spec.colours[Math.min(spec.colours.length-1,Math.floor(t*spec.colours.length))];
  const x=t*(spec.colours.length-1),i=Math.min(spec.colours.length-2,Math.floor(x));
  return mixColour(spec.colours[i],spec.colours[i+1],x-i);
}
function make3DTraces(){
  if (terrainState.id !== 'island') return glacierBodyTraces();
  const s=terrainState,data=s.data,base=data.surface;
  const selected=data.options.find(o=>o.id===$('terrain-colour').value);
  const spec=selected?selected.style:D.elevation_style, values=selected?selected.values:base;
  const showIce=$('terrain-ice').checked,mask=data.ice[years[s.index]],iceColour=colours[years[s.index]];
  // One mesh: colour codes carry the optional ice tint; extra coplanar surfaces waste GPU memory.
  const palette=['#334a59',...Array.from({length:127},(_,i)=>samplePalette(spec,i/126))];
  palette.push(...palette.map(c=>mixColour(c,iceColour,.4)));
  const codes=base.map((row,r)=>row.map((z,c)=>{
    const v=values[r][c];let code=v===null?0:1+Math.round(Math.max(0,Math.min(1,(v-spec.limits[0])/(spec.limits[1]-spec.limits[0])))*126);
    if(!selected&&showIce&&mask&&mask[r][c]==='1')code+=128;
    return code;
  }));
  const trace=surfaceTrace(data,base,codes,{limits:[0,255],colours:palette},selected?selected.title:'2002 surface');
  const traces=[trace];
  if(showIce){
    const line=data.lines[years[s.index]]||[],x=[],y=[],z=[];
    line.forEach(l=>{x.push(...l.x,null);y.push(...l.y,null);z.push(...l.surface.map(v=>v===null?null:v+14),null);});
    if(x.length)traces.push({type:'scatter3d',mode:'lines',x,y,z,line:{color:iceColour,width:5},connectgaps:false,showlegend:false,hoverinfo:'skip',name:'Inventory boundary'});
  }
  return traces;
}
function sceneLayout(){
  const s=terrainState,d=s.data,ex=Number($('terrain-exaggeration').value);
  const dx=Math.max(...d.x)-Math.min(...d.x),dy=Math.max(...d.y)-Math.min(...d.y),span=Math.max(dx,dy,.1);
  const model = s.id === 'island' ? null : glacierIceModel(d);
  const all = d.surface.flat().filter(Number.isFinite);
  if (model) {
    model.top.forEach((row, r) => row.forEach((height, c) => {
      if (Number.isFinite(height)) {
        const bed = d.bed[r][c];
        all.push(bed, bed + model.thickness.values[r][c] * iceThicknessFactor());
      }
    }));
  }
  const lo = Math.min(...all), hi = Math.max(...all);
  const zr=Math.max(hi-lo,100),range=[lo-30,hi+30];
  return {paper_bgcolor:'#0b1420',plot_bgcolor:'#0b1420',font:{family:'system-ui,sans-serif',color:'#bccbd7',size:10},
    margin:{l:0,r:0,t:0,b:0},showlegend:false,uirevision:s.id,
    scene:{uirevision:s.id,bgcolor:'#0b1420',dragmode:'orbit',camera:s.camera||terrainCamera,
      aspectmode:'manual',aspectratio:{x:dx/span,y:dy/span,z:(zr+60)/1000/span*ex},
      xaxis:{title:{text:'Easting offset (km)'},showbackground:false,gridcolor:'#26384b',zeroline:false},
      yaxis:{title:{text:'Northing offset (km)'},showbackground:false,gridcolor:'#26384b',zeroline:false},
      zaxis:{title:{text:iceThicknessFactor() === 1 ? 'Elevation (m)' : 'Displayed height (m)'},showbackground:false,gridcolor:'#26384b',zeroline:false,range}},
    annotations:[{text:esc(d.name) + (s.id === 'island' ? ' · 2002 SURFACE' : ' · MODELLED ICE BODY · THICKNESS ' + iceThicknessFactor() + '×'),xref:'paper',yref:'paper',x:.03,y:.97,xanchor:'left',showarrow:false,font:{color:'#e8eff5',size:13}}]};
}
async function drawTerrain(){
  const s=terrainState;if(!s||!s.data.available||!window.Plotly)return;
  if(s.drawing){s.pending=true;return;}
  s.drawing=true;
  try{
    const plot=$('terrain-plot');
    if(plot._fullLayout?.scene?.camera)s.camera=JSON.parse(JSON.stringify(plot._fullLayout.scene.camera));
    await Plotly.react(plot,make3DTraces(),sceneLayout(),{responsive:true,plotGlPixelRatio:1,displaylogo:false,scrollZoom:true,modeBarButtonsToRemove:['toImage'],displayModeBar:true});
    const option=s.data.options.find(o=>o.id===$('terrain-colour').value);
    $('terrain-legend').innerHTML=legend(option?option.style:D.elevation_style)+(option?'<p>Grey = no value for this colour layer. The dated ice footprint is outlined so its tint does not alter the data colours.</p>':'<p>The dated footprint is tinted when enabled. Untick it to inspect unblended elevation colours.</p>');
    if (s.id !== 'island') {
      $('terrain-legend').innerHTML = legend(option ? option.style : D.elevation_style)
        + '<p>Colours apply to the ice body. Grey ice has no value for the selected layer; dark grey is terrain context.</p>';
    }
    $('terrain-year').textContent=years[s.index];$('terrain-year-range').value=s.index;
    $('terrain-date-status').textContent=!s.data.ice[years[s.index]]?'No saved outline for this date.':years[s.index]>2014 && (s.id==='island'||!focus.includes(s.data.name))?'Recent non-focus inventories are provisional.':'Mapped inventory date · fixed terrain.';
    if (s.id !== 'island' && s.data.ice[years[s.index]]) {
      const body = $('terrain-plot').data.find(trace => trace.type === 'mesh3d');
      $('terrain-date-status').textContent = body
        ? 'Fixed thickness model clipped to the ' + years[s.index] + ' outline.'
        : !$('terrain-ice').checked ? 'Ice body hidden.'
          : 'No modelled ice body overlaps this outline on the display grid.';
      if (years[s.index] > 2014 && !focus.includes(s.data.name)) {
        $('terrain-date-status').textContent += ' Recent outline is provisional.';
      }
    }
  }catch(error){s.error=error.message;if(window.Plotly)Plotly.purge($('terrain-plot'));if(terrainState===s)$('terrain-plot').innerHTML='<div class="plot-error">3D rendering could not start. Check that WebGL/hardware acceleration is enabled in your browser.<br>'+esc(String(error.message).slice(0,300))+'</div>';stopTerrain();}
  finally{s.drawing=false;if(s.pending&&terrainState===s){s.pending=false;drawTerrain();}}
}
function stopTerrain(){if(!terrainState)return;terrainState.playing=false;clearTimeout(terrainState.timer);if($('terrain-play'))$('terrain-play').textContent='▶ Play';}
async function stepTerrain(){const s=terrainState;if(!s?.playing)return;await drawTerrain();if(terrainState!==s||!s.playing)return;s.timer=setTimeout(()=>{s.index=(s.index+1)%5;stepTerrain();},1350);}
async function openTerrain(id){
  stopTerrain();island.timeline.pause();if(glacierView)glacierView.timeline.pause();
  const definition=id==='island'?{name:'Heard Island',terrain:'assets/data/island_terrain.js'}:D.glaciers.find(g=>g.id===id);
  if(!definition)return;
  $('terrain-title').textContent=definition.name;$('terrain-plot').innerHTML='<div class="loading">Loading terrain…</div>';
  if(!$('terrain-dialog').open)$('terrain-dialog').showModal();
  const state={id,data:null,index:2,playing:false,drawing:false,camera:null};terrainState=state;
  try{
    await Promise.all([window.Plotly?Promise.resolve():loadScript(D.plotly_url),H.terrain[id]?Promise.resolve():loadScript(definition.terrain)]);
    if(terrainState!==state||!$('terrain-dialog').open)return;
    const data=H.terrain[id];state.data=data;
    if(!data?.available){$('terrain-plot').innerHTML='<div class="plot-error"><h3>Terrain is unavailable for this view</h3>'+esc(data?.reason||'No terrain asset was produced.')+'</div>';return;}
    $('terrain-colour').innerHTML='<option value="elevation">Elevation</option>'+data.options.map(o=>`<option value="${esc(o.id)}">${esc(o.title)}</option>`).join('');
    const glacierBody = id !== 'island';
    $('thickness-controls').hidden = !glacierBody;
    $('terrain-thickness').value = 1;
    $('terrain-thickness-label').textContent = '1×';
    $('terrain-thickness').oninput = event => {
      $('terrain-thickness-label').textContent = event.target.value + '×';
      drawTerrain();
    };
    $('terrain-dialog').querySelector('.terrain-controls > .scope-note').textContent =
      glacierBody ? 'Modelled ice thickness in 3D' : 'Surface terrain · 2002 DEM';
    $('terrain-dialog').querySelector('label[for="terrain-colour"]').textContent =
      glacierBody ? 'Colour the ice body by' : 'Colour the terrain by';
    $('terrain-ice').parentElement.lastChild.textContent =
      glacierBody ? ' Show ice body and dated outline' : ' Show dated ice footprint';
    $('terrain-dialog').querySelector('.terrain-note').innerHTML = glacierBody
      ? '<strong>What this model shows</strong><p>A fixed ice volume from modelled thickness and the derived bed. The bed combines the 2002 DEM with a thickness model representative of 2010–2020.</p><p>Animation clips this volume to mapped outlines. Earlier ice beyond model coverage is shown only as an outline. Data gaps stay blank; vertical walls mark display cut faces.</p>'
      : '<strong>What this animation shows</strong><p>Mapped ice footprints on the fixed 2002 surface. It does not reconstruct historical surface heights or thickness.</p>';
    if (glacierBody && data.options.some(option => option.id === 'thickness')) {
      $('terrain-colour').value = 'thickness';
    }
    $('terrain-exaggeration').value=1;$('terrain-exaggeration-label').textContent='1×';$('terrain-ice').checked=true;
    $('terrain-timeline').innerHTML='<div class="timeline-title">RETREAT · MAPPED DATES</div><div class="timeline-main"><button id="terrain-play">▶ Play</button><input id="terrain-year-range" type="range" min="0" max="4" value="2" step="1" aria-label="3D inventory date"><output id="terrain-year" class="timeline-year">2014</output></div><div class="timeline-dates">'+years.map(y=>`<span>${y}</span>`).join('')+'</div>';
    $('terrain-grid-note').textContent=`Display grid: ${data.shape[1]} × ${data.shape[0]} cells; approximately ${Math.round(data.display_cell_m[0])} m spacing. Original analytical rasters are unchanged.`;
    $('terrain-play').onclick=()=>{if(state.playing)stopTerrain();else{state.playing=true;$('terrain-play').textContent='Ⅱ Pause';stepTerrain();}};
    $('terrain-year-range').oninput=e=>{stopTerrain();state.index=Number(e.target.value);drawTerrain();};
    $('terrain-colour').onchange=()=>drawTerrain();$('terrain-ice').onchange=()=>drawTerrain();
    $('terrain-exaggeration').oninput=e=>{$('terrain-exaggeration-label').textContent=e.target.value+'×';drawTerrain();};
    $('terrain-sources').onclick=()=>openCredits([...new Set([...data.sources,...data.options.flatMap(o=>o.sources)])]);
    $('terrain-reset').onclick=()=>{state.camera=JSON.parse(JSON.stringify(terrainCamera));Plotly.relayout($('terrain-plot'),{'scene.camera':state.camera});};
    $('terrain-plot').replaceChildren();await drawTerrain();
  }catch(error){if(terrainState===state)$('terrain-plot').innerHTML='<div class="plot-error">'+esc(error.message)+'</div>';}
}

// BROWN_LAGOON_VIEWER
let lagoonState = null;
const lagoonCamera = {eye: {x: 1.4, y: -1.6, z: 1.1}, up: {x: 0, y: 0, z: 1}};

function lagoonTraces(data) {
  const faces = {x: data.x, y: data.y, i: data.i, j: data.j, k: data.k};
  const traces = [{...faces, type: 'mesh3d', z: data.z,
    intensity: data.z.map(z => -z), customdata: data.z.map(z => -z),
    colorscale: plotlyScale(data.style), cmin: 0, cmax: 60,
    showscale: false, showlegend: false, name: 'Interpolated bed',
    lighting: {ambient: .7, diffuse: .7, specular: .12, roughness: .9},
    hovertemplate: 'Interpolated depth: %{customdata:.1f} m<extra>2004 basin</extra>'}];
  // The plane reuses accepted faces, so no water is invented across survey gaps.
  if ($('lagoon-water').checked) traces.push({...faces, type: 'mesh3d',
    z: data.z.map(() => 0), color: '#69D5FF', opacity: .2,
    name: 'Survey water plane', hoverinfo: 'skip', showlegend: false});
  if ($('lagoon-soundings').checked && data.soundings.length) {
    traces.push({type: 'scatter3d', mode: 'markers', name: '2004 soundings',
      x: data.soundings.map(p => p[0]), y: data.soundings.map(p => p[1]),
      z: data.soundings.map(p => p[2]), customdata: data.soundings.map(p => -p[2]),
      marker: {size: 2.5, color: '#E7EDF2', opacity: .9}, showlegend: false,
      hovertemplate: 'Measured depth: %{customdata:.1f} m<extra>2004 sounding</extra>'});
  }
  return traces;
}

function lagoonLayout(data, state) {
  const allX = [...data.x, ...data.soundings.map(p => p[0])];
  const allY = [...data.y, ...data.soundings.map(p => p[1])];
  const low = Math.min(...data.z, ...data.soundings.map(p => p[2]));
  const dx = Math.max(...allX) - Math.min(...allX);
  const dy = Math.max(...allY) - Math.min(...allY), span = Math.max(dx, dy, 1);
  const padding = Math.max(2, -low * .05), range = [low - padding, padding];
  const factor = Number($('lagoon-exaggeration').value);
  return {paper_bgcolor: '#0b1420', font: {color: '#bccbd7', family: 'system-ui', size: 10},
    margin: {l: 0, r: 0, t: 0, b: 0}, showlegend: false,
    scene: {uirevision: 'Brown-lagoon', bgcolor: '#0b1420', dragmode: 'orbit',
      camera: state.camera || lagoonCamera, aspectmode: 'manual',
      aspectratio: {x: dx / span, y: dy / span, z: (range[1] - range[0]) / span * factor},
      xaxis: {title: {text: 'Local easting (m)'}, range: [Math.min(...allX), Math.max(...allX)],
        showbackground: false, gridcolor: '#26384b'},
      yaxis: {title: {text: 'Local northing (m)'}, range: [Math.min(...allY), Math.max(...allY)],
        showbackground: false, gridcolor: '#26384b'},
      zaxis: {title: {text: 'Height relative to survey water (m)'}, range,
        showbackground: false, gridcolor: '#26384b'}},
    annotations: [{text: 'BROWN LAGOON · 2004 · VERTICAL ' + factor + '×',
      xref: 'paper', yref: 'paper', x: .03, y: .97, xanchor: 'left',
      showarrow: false, font: {color: '#e8eff5', size: 13}}]};
}

async function drawLagoon() {
  const state = lagoonState, plot = $('lagoon-plot');
  if (!state?.data?.available || !$('lagoon-dialog').open) return;
  if (state.drawing) {state.pending = true; return;}
  state.drawing = true;
  try {
    if (plot._fullLayout?.scene?.camera)
      state.camera = JSON.parse(JSON.stringify(plot._fullLayout.scene.camera));
    await Plotly.react(plot, lagoonTraces(state.data), lagoonLayout(state.data, state),
      {responsive: true, plotGlPixelRatio: 1, displaylogo: false, scrollZoom: true});
  } catch (error) {
    if (lagoonState === state) {
      Plotly.purge(plot);
      plot.innerHTML = '<div class="plot-error">Could not render the lagoon: '
        + esc(error.message) + '</div>';
    }
  } finally {
    state.drawing = false;
    if (lagoonState === state && state.pending) {state.pending = false; drawLagoon();}
    else if (!lagoonState) Plotly.purge(plot);
  }
}

async function openLagoon() {
  stopTerrain(); island.timeline.pause(); glacierView?.timeline.pause();
  const state = {data: null, camera: null, drawing: false}; lagoonState = state;
  $('lagoon-plot').innerHTML = '<div class="loading">Loading surveyed basin…</div>';
  if (!$('lagoon-dialog').open) $('lagoon-dialog').showModal();
  try {
    await Promise.all([
      window.Plotly ? Promise.resolve() : loadScript(D.plotly_url),
      H.lagoons?.Brown ? Promise.resolve() : loadScript('assets/data/Brown_lagoon_3d.js')]);
    if (lagoonState !== state || !$('lagoon-dialog').open) return;
    state.data = H.lagoons?.Brown;
    if (!state.data?.available) throw new Error(state.data?.reason || 'No lagoon mesh was exported.');
    $('lagoon-exaggeration').value = 3; $('lagoon-exaggeration-label').textContent = '3×';
    $('lagoon-water').checked = true; $('lagoon-soundings').checked = true;
    $('lagoon-soundings').parentElement.hidden = !state.data.soundings.length;
    $('lagoon-legend').innerHTML = legend(state.data.style)
      + '<p>White points = measured soundings. Untick the water plane to inspect the bed.</p>';
    $('lagoon-exaggeration').oninput = event => {
      $('lagoon-exaggeration-label').textContent = event.target.value + '×'; drawLagoon();
    };
    $('lagoon-water').onchange = drawLagoon; $('lagoon-soundings').onchange = drawLagoon;
    $('lagoon-reset').onclick = () => {
      state.camera = JSON.parse(JSON.stringify(lagoonCamera));
      Plotly.relayout($('lagoon-plot'), {'scene.camera': state.camera});
    };
    $('lagoon-sources').onclick = () => openCredits(state.data.sources);
    $('lagoon-plot').replaceChildren(); await drawLagoon();
  } catch (error) {
    if (lagoonState === state) $('lagoon-plot').innerHTML =
      '<div class="plot-error">' + esc(error.message) + '</div>';
  }
}
$('lagoon-dialog').addEventListener('close', () => {
  lagoonState = null;
  if (window.Plotly) Plotly.purge($('lagoon-plot'));
  $('lagoon-plot').replaceChildren();
});
window.addEventListener('resize', () => {
  if ($('lagoon-dialog').open && $('lagoon-plot')._fullLayout) Plotly.Plots.resize($('lagoon-plot'));
});
$('methods-details').insertAdjacentHTML('beforeend',
  '<p>Brown lagoon 3D reuses the accepted mesh from notebook 06. Horizontal offsets '
  + 'and relative heights are in metres. The 2004 survey water surface is 0 m; '
  + 'its elevation above sea level is unresolved. Water-plane coverage follows '
  + 'interpolation support. Vertical exaggeration changes aspect ratio only.</p>');
$('island-3d').onclick=()=>openTerrain('island');
$('terrain-dialog').addEventListener('close',()=>{stopTerrain();if(window.Plotly)Plotly.purge($('terrain-plot'));terrainState=null;$('terrain-plot').replaceChildren();});
window.addEventListener('resize',resizeViews);
// Expose a small inspection surface for diagnostics and automated interaction checks.
H.app={openGlacier,openTerrain,openCredits,get island(){return island;},get glacier(){return glacierView;},get terrain(){return terrainState;}};
})();

