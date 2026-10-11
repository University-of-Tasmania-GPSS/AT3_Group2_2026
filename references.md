(references)=
# References and data credits

% AUTHORING: Fill this page with the sources actually used in the book. Keep APA 7 formatting, stable links/DOIs and full data-product names. Every in-text author–date citation should have an entry here; every entry should have a clear role in the book.

## Scientific literature

Allison, I. F., & Keage, P. L. (1986). Recent changes in the glaciers of Heard Island. Polar Record, 23(144), 255-272. 
Fox, J. M., McPhie, J., Carey, R. J., Jourdan, F., & Miggins, D. P. (2021). Construction of an intraplate island volcano: The volcanic history of Heard Island. Bulletin of Volcanology, 83(5), 37. 
Kiernan, K., & McConnell, A. (2002). Glacier retreat and melt-lake expansion at Stephenson Glacier, Heard Island World Heritage area. Polar Record, 38(207), 297-308. 
Quilty, P. G., & Wheller, G. E. (2000). Heard Island and the McDonald Islands: a window into the Kerguelen Plateau. 
Thost, D. E., & Truffer, M. (2008). Glacier recession on Heard Island, southern Indian ocean. Arctic, Antarctic, and Alpine Research, 40(1), 199-214. 
Tielidze, L. G., Mackintosh, A. N., & Yang, W. (2025). Glacier inventories reveal an acceleration of Heard Island glacier loss over recent decades. The Cryosphere, 19(7), 2677-2694. 


## Data sources
Heard Island glacier fluctuations: 2003/04 fieldwork Allison, I., & Thost, D. E. (2010). Heard Island glacier fluctuations and climatic change—2003/04 fieldwork (Version 1) [Data set]. Australian Antarctic Data Centre. https://doi.org/10.4225/15/574BBEA0D74B7
HIMI coastline polygon: himi_coastline_py.gpkg Australian Antarctic Data Centre. (n.d.). Heard Island and McDonald Islands coastline polygons [Data set]. https://www.antarctica.gov.au/antarctic-operations/stations-and-field-locations/heard-island/mapping/
Heard Island RADARSAT (2002) DEM Brolsma, H., & Smith, D. T. (2008). Heard Island RADARSAT (2002) digital elevation model (DEM) (Version 1) [Data set]. Australian Antarctic Data Centre. https://data.aad.gov.au/metadata/records/heard_dem_radarsat02
Esri. (2026.10.11). World imagery [Basemap]. Retrieved October 11, 2026, from https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer

### Original lagoon mapping and project digitisation
Heard Island lagoon outlines Donoghue, S., & Harris, U. (2021). Fluctuations of Heard Island glaciers between 1947–2014 [Data set]. Australian Antarctic Data Centre. https://data.aad.gov.au/metadata/Heard_Island_glacier_fluctuations_2012-2014
Griffin. (2026). Updated Heard Island lagoon outlines [Unpublished digitised data set].
European Space Agency. (n.d.). Copernicus Sentinel-1 synthetic aperture radar imagery [Data set]. https://sentiwiki.copernicus.eu/web/s1-mission

### Archived field observations
[Write: Reuse the verified Allison and Thost field-data citation from the map source register. Consolidate the Brown campaign archive under that entry, retaining relevant archive links without presenting duplicate references as independent observations.]

### Geological mapping
Fox, J., Carey, R. J., & McPhie, J. (2023). Heard Island geology map—Compiled from data collected from 1929–2020 (Version 1) [Data set]. Australian Antarctic Data Centre. https://doi.org/10.26179/nb02-vj63

## Technical documentation

Rasterio: virtual warping and bounded raster reads https://rasterio.readthedocs.io/en/stable/topics/virtual-warping.html
Rasterio: validity masks and NoData https://rasterio.readthedocs.io/en/stable/topics/masks.html
Rasterio: rasterisation and polygon masks https://rasterio.readthedocs.io/en/stable/topics/features.html
Shapely: set difference for lost glacier footprint https://shapely.readthedocs.io/en/stable/reference/shapely.difference.html
Leaflet 1.9.4: maps, GeoJSON, image overlays and event propagation https://leafletjs.com/reference-1.9.4.html
Plotly.js: 3D surface plots https://plotly.com/javascript/3d-surface-plots/
Plotly.js: camera, axes and 3D scene controls https://plotly.com/javascript/reference/layout/scene/
IPython: IFrame notebook display https://ipython.readthedocs.io/en/stable/api/generated/IPython.display.html#IPython.display.IFrame
Plotly. (n.d.). 3D mesh plots in JavaScript [Documentation]. https://plotly.com/javascript/3d-mesh/
MDN Web Docs. (n.d.). <input type="range"> [Documentation]. https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/input/range
NumPy Developers. (n.d.). numpy.load [Documentation]. https://numpy.org/doc/stable/reference/generated/numpy.load.html
Leaflet. (n.d.). Leaflet API reference [Documentation]. https://leafletjs.com/reference.html
Franklin, W. R. (n.d.). PNPOLY—Point inclusion in polygon test. https://wrfranklin.org/Research/Short_Notes/pnpoly.html

Display rasters use nearest-neighbour reprojection and preserve source masks. Glacier views include the available dated footprints plus a 600 m buffer. Display geometries are simplified by 4 m after area calculations.
3D views use EPSG:32743, with horizontal distances in kilometres and elevations in metres. Retreat animations step through mapped dates on fixed terrain; they do not reconstruct historical ice thickness. Equal animation steps represent unequal time intervals.
Map interface: Leaflet 1.9.4 (BSD-2-Clause). 3D interface: Plotly.js 3.1.0 (MIT).
Brown lagoon 3D reuses the accepted mesh from notebook 06. Horizontal offsets and relative heights are in metres. The 2004 survey water surface is 0 m; its elevation above sea level is unresolved. Water-plane coverage follows interpolation support. Vertical exaggeration changes aspect ratio only.

## Photographs, maps and figure credits

| Item | Creator or original source | Date/version | Where used | Reuse basis or attribution |
| --- | --- | --- | --- | --- |
| Opening photograph | [Write] | [Write] | Introduction | [Write] |
| Study-area basemap | [Write] | [Write] | Introduction | [Write] |
| Geology methods figure | James's preparation; original dataset [Write] | [Write] | Methods | [Write] |
| Surface terrain derivatives | James's GDAL workflow; DEM source [Write] | [Write] | Methods | [Write] |
| Other project figures | [Write: credit both contributors accurately and list original input sources in captions] | [Write] | Methods/Results/Discussion | [Write] |

% AUTHORING: Preserve authorship in the figure register and README without turning captions into contribution statements. Captions still need original data credits. Avoid separate duplicate entries for the same source.

## Expedition and future-observation sources

Australian Antarctic Program heads to Heard Island – Australian Antarctic Program (News 2025). (2025, August 4). Antarctica.Gov.Au. https://www.antarctica.gov.au/news/2025/australian-antarctic-program-heads-to-heard-island-for-the-first-time-in-decades/
