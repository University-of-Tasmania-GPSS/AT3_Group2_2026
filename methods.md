(methods)=
# Methods: building a defensible comparison

[Write: Explain the overall approach in one paragraph: measure mapped change, compare spatial context, then test how far independent field evidence supports the interpretation.]

(data-overview)=
## Data, dates and spatial coverage

[Write: Introduce the datasets with their observation dates, native resolution, analysis support and purpose. Distinguish observation date from publication date.]

| Evidence | What to record here | Purpose in the comparison |
| --- | --- | --- |
| Historical glacier outlines | Source, nominal dates, matching decisions and mapping limitations | Area and front change |
| Sentinel-1 imagery | Acquisition dates, coherence pairs, orbit, polarisation and processing | Recent outline reconstruction |
| Surface elevation | DEM source, observation period, vertical reference and resolution | Elevation, slope, aspect and terrain context |
| Modelled ice thickness | Product version, representative period, resolution and error layer | Estimate subglacial terrain |
| ITS_LIVE velocity | Product version, image-pair dates, filters and retained coverage | Contemporary flow context |
| Geology | Map source, units, scale and unmapped areas | Exposed geological context |
| Field archives | Radar and sounding dates, registration and vertical reference | Local comparisons and lagoon reconstruction |

% TODO: Replace the prompts above with verified metadata. Full APA citations belong in references.md; detailed export names and environments belong in the appendix.

### Aligning grids and footprints

[Write: Explain reprojection, resampling and valid-data masks. Distinguish the 50 m terrain grid, 120 m exposure/velocity support and 10 m lagoon output. Explain why the 2019 thickness mask, 2014 velocity footprint and common elevation surface serve different questions.]

**Limitation:** [Write: Dates, grids and masks differ; resampling does not create new information.]  
**Response:** [Write: Describe the alignment and valid-data rules used for each comparison.]  
**Implication:** [Write: State which comparisons remain descriptive and which quantities should not be treated as coeval.]


(workflow)=
## Workflow from observations to synthesis

:::{admonition} Figure placeholder — analytical workflow
Create a compact diagram with branches for inventory change, terrain and flow, exposed geology, and field reconstruction, joining at the synthesis. Show the main support checks beside the branches. Avoid an exhaustive notebook-by-notebook flowchart.
:::

[Write: Describe the main Python/GIS tools and the decisions they implement. Link the complete code through the appendix; retain only a few short, explained snippets in this chapter.]

(methods-outlines)=
## Reconstructing glacier outlines and measuring retreat

### Historical matching and recent radar evidence

[Write: Explain historical identity matching and retained unmatched features. Explain coherence, backscatter and the recent outline algorithm using plain language before its parameters.]

:::{figure} Figures/Inventory_methods_SAR_evidence.png
:label: fig-methods-sar
:alt: Four maps comparing Sentinel-1 coherence and backscatter evidence for recent Heard Island glacier mapping.
:width: 100%
:align: center

[Caption placeholder: Identify the panels, acquisition dates and what coherence/backscatter contribute. Explain ambiguous low coherence and masked or unusable observations. Credit Sentinel-1 and processing sources.]
:::

% FIGURE STATUS: Polish this methods figure later; add title, panel letters, readable keys and focus-glacier annotations. Do not imply that low coherence uniquely identifies ice.

### Area loss and front displacement

[Write: Define the polygon area change, percentage denominator and interval annualisation. Explain that the transect measures front displacement along a selected route, while area loss measures change in the whole mapped footprint.]

**Selected code snippet placeholder:** Insert a short, actual excerpt for polygon difference or interval-normalised change. Add # comments and explain the inputs, denominator and output. Use a static Python code fence, not an executable cell.

**Limitation:** [Write: Nominal historical dates, uncertain boundaries, radar ambiguity and the imposed inventory rules.]  
**Response:** [Write: Explain land/lagoon masks, the retained high-elevation 2014 footprint, the no-advance constraint and audit of unmatched features.]  
**Implication:** [Write: Pixel size is not outline accuracy; changes in constrained areas and provisional non-focus inventories require particular care.]


(methods-geology)=
## Comparing mapped geology with newly exposed terrain

[Write: Introduce island-wide geology preparation before the focus-glacier overlay. Explain geometry repair, reprojection to EPSG:32743, clipping to the coastline, and retention of the source Rock_Type categories.]

(fig-methods-geology-placeholder)=
:::{admonition} Figure placeholder — mapped geology and unit coverage
**Source:** `03_Geology_Analysis_working.ipynb`, the cells headed `Interactive geology map (Leaflet) and clipped shapefile export` and `Area covered by each rock type`.

Prepare a static companion to the existing geology map, paired with the unit-area summary. Show mapped units, the coastline and Brown/Stephenson locations. Keep Snow/Ice and unknown units visible. Describe area shares as shares of the clipped mapped geology, with the denominator stated explicitly.

**Planned export:** `Figures/Methods/03_mapped_geology_context.png`.

**Caption placeholder:** Identify source-map coverage, polygon clipping, mapped unit categories, area units and denominator. Credit the geological dataset and distinguish preparation from the later retreat-zone analysis.
:::

% FIGURE STATUS: Add geology methods figure to the polish queue. The notebook saves geology_map.html and a table, but the supplied snapshot has no static export of this map. Do not use notebook 08's results figure as a substitute for explaining the original geology preparation.

[Write: Explain how retreat zones were intersected with geological polygons. Define the categories, denominators and handling of Snow/Ice and unmapped areas.]

**Selected code snippet placeholder:** Use a short excerpt from geology clipping/area calculation. Explain why area is measured in the projected CRS, and why the Snow/Ice category does not reveal the buried substrate.

**Limitation:** [Write: The map describes exposed units and may leave former ice-covered terrain unresolved.]  
**Response:** [Write: Keep unknown categories explicit; do not extend adjacent geological units beneath the ice.]  
**Implication:** [Write: The overlay describes spatial association and exposure, not the erodibility or composition of an observed glacier bed.]


(methods-surface-terrain)=
## Deriving surface slope, aspect and hillshade

[Write: Explain GDAL terrain-derivative workflow. Define slope as steepness, aspect as the downslope compass direction, and hillshade as simulated illumination for viewing terrain. These describe the DEM surface, including the ice surface where present.]

:::{figure} Figures/Methods/04_surface_terrain_derivatives.png
:label: fig-methods-surface-terrain
:alt: Three-panel Heard Island surface DEM figure showing hillshade, slope in degrees and aspect clockwise from north, with 2019 glacier outlines.
:width: 100%
:align: center

[Caption placeholder: Describe the RADARSAT 2002 DEM and its 1997 input, native 10 m grid, coastline clipping, GDAL derivative calculations and 2019 outline overlay. Define slope/aspect units and flat or missing aspect cells. Hillshade uses simulated illumination, not measured solar exposure. Credit the DEM and inventory sources.]
:::

% FIGURE STATUS: Extracted unchanged from saved notebook 04 output, cell headed by the style_path assignment after 'Plot all of these derivatives'. Polish later: reduce excess space, add panel letters, label focus glaciers and the 2019 key, and use clear compass ticks for the cyclic aspect scale. Do not confuse this with the separate candidate-bed derivative figure.

**Selected code snippet placeholder:** Include a short GDAL DEMProcessing excerpt from derivative functions. Explain the input, derivative type, units and treatment of flat/missing cells. Choose this OR the geology excerpt for the main chapter if both would overcrowd it; put the second in the appendix.

**Limitation:** [Write: DEM age, mixed source periods, documented artefacts and scale-dependent terrain derivatives.]  
**Response:** [Write: Use the accepted clipped DEM, preserve missing cells and distinguish surface derivatives from those calculated on the modelled bed.]  
**Implication:** [Write: These layers describe the recorded surface; they cannot directly reveal buried valley form or establish radiation/melt differences.]


(methods-terrain)=
## Estimating subglacial terrain

[Write: Explain modelled bed elevation = surface elevation − modelled ice thickness. Describe grid alignment, the positive-thickness mask, lagoon exclusions and the reported thickness error product.]

:::{figure} Figures/Brown_Stephenson_thickness_and_bed.png
:label: fig-methods-terrain
:alt: Maps of modelled ice thickness and derived bed elevation for Brown and Stephenson glaciers.
:width: 100%
:align: center

[Caption placeholder: Identify thickness and bed panels, common scales, footprint dates, model period and valid-data mask. Credit both elevation and thickness sources.]
:::

% FIGURE STATUS: Polish this methods figure later. Clarify dates, common scales, masks and the surface-minus-thickness construction. Coverage does not establish accuracy.

**Selected code snippet placeholder:** Insert the actual masked subtraction used in notebook 04, with # comments explaining valid cells, vertical units and missing data. Explain why missing thickness cannot be assigned zero.

**Limitation:** [Write: Non-coeval elevation and thickness; model error; incomplete coverage; the thickness product's use of velocity.]  
**Response:** [Write: Retain error and support information and compare only registered field sections where possible.]  
**Implication:** [Write: This is modelled terrain, and agreement with flow is not fully independent validation.]


(methods-transects)=
## Sampling glacier geometry and possible bed controls

:::{figure} Figures/09_Synthesis/04a_transect_locations.png
:label: fig-methods-transects
:alt: Brown and Stephenson maps showing longitudinal transects, cross-sections, inventories and field evidence.
:width: 100%
:align: center

[Caption placeholder: Define each route, distance origin, front intersections, cross-section lines and sounding symbols. State that these are selected sampling routes and explain why they were chosen.]
:::

% FIGURE STATUS: Finished notebook 08 figure; reuse unchanged.

### Fronts, corridor width and flow samples

[Write: Explain route construction, connected front selection, distance sampling and mapped corridor width. Explain the velocity and terrain sampling resolutions.]

### Screening modelled bed highs

[Write: Explain smoothing, prominence/separation rules, wider smoothing, lateral offsets and thickness-error perturbations. Define the persistence counts without presenting them as probabilities.]

**Limitation:** [Write: Selected routes, incomplete raster coverage and uncertain modelled bed form.]  
**Response:** [Write: Inspect cross-sections and sensitivity trials, retaining unsupported trials explicitly.]  
**Implication:** [Write: A local high is a candidate geometric influence, not proof of a valley-wide barrier or glacier pinning point.]


(methods-field)=
## Recovering archived radar and lagoon observations

### Radar registration and vertical references

[Write: Distinguish raw/workbook return proxies from archived interpreted bed sections. Explain georeferencing, vertical checks, matching to model cells and the exclusion of the problematic BG35 registration from primary metrics.]

**Limitation:** [Write: Sparse, older observations; uncertain registration and vertical alignment; few independent model cells.]  
**Response:** [Write: Preserve registration audits and use only eligible interpreted sections for primary comparisons.]  
**Implication:** [Write: Local agreement or disagreement cannot validate the entire modelled glacier bed.]

### Lagoon interpolation, support and spatial validation

[Write: Explain triangulation and linear interpolation, the 150 m maximum triangle-edge rule, 100 m nearest-sounding limit, non-extrapolation and 10 m output grid. Explain the 100 m spatial block holdout.]

:::{figure} Figures/06_Brown_lagoon_bathymetry_QA.png
:label: fig-methods-lagoon-qa
:alt: Brown Lagoon maps of interpolated depths, distance to soundings and spatial holdout residuals.
:width: 100%
:align: center

[Caption placeholder: Explain all three panels, accepted support, held-out predictions and the residual sign. State that accuracy metrics apply only where a prediction passed the support rules. Credit the survey archive.]
:::

% FIGURE STATUS: Polish this methods figure later; clarify unsupported predictions and the key.

**Selected code snippet placeholder:** Insert the actual support-mask logic from notebook 06, with # comments. Explain how withholding nearby observations differs from a random split.

**Limitation:** [Write: Uneven and incomplete survey coverage, sparse Stephenson soundings, and depths relative to the survey's water surface.]  
**Response:** [Write: Retain the supported basin only, test support sensitivity, and keep the two lagoon evidence bases separate.]  
**Implication:** [Write: Supported depth-area totals do not describe the entire lagoon or establish a common sea-level datum.]


(methods-velocity)=
## Summarising contemporary glacier flow

[Write: Describe the 2016–2022 ITS_LIVE image-pair selection, Sentinel-1 contribution, time separation, vector filtering, minimum pair count and direction consistency. Define the speed statistic and coverage denominator.]

:::{figure} Figures/07_velocity_focus_maps.png
:label: fig-methods-velocity
:alt: Brown and Stephenson maps showing contemporary velocity estimates and their spatial coverage.
:width: 100%
:align: center

[Caption placeholder: Explain the 2014 sampling footprint, 2016–2022 velocity period, common speed scale and missing-data areas. Credit ITS_LIVE and its contributing imagery.]
:::

% FIGURE STATUS: Polish this methods figure later; clarify period, masks, scale and coverage.

**Limitation:** [Write: Uneven retained coverage, especially on Brown's lower glacier; filtering can remove slow or inconsistent flow.]  
**Response:** [Write: Report lower-third filter audits, threshold sensitivity, pair-error context and temporal sampling alongside speed.]  
**Implication:** [Write: Gaps are not stationary ice; the observed speed contrast is conditional on retained samples.]


(methods-solar)=
## Comparing summer surface exposure

[Write: Explain how the DEM-derived slope and aspect enter a surface-normal calculation. Describe the November–February dates, hourly solar geometry, declination approximation and normalisation against a horizontal surface.]

**Limitation:** [Write: The index excludes clouds, albedo, atmospheric effects, terrain shadows and melt physics.]  
**Response:** [Write: Describe it as a geometric incidence comparison, with explicit data coverage and footprint/elevation masks.]  
**Implication:** [Write: It is not measured radiation, an energy balance or a calculation of melt.]


(methods-synthesis)=
## Integrating evidence without overstating causation

[Write: Explain how each dataset answers a different part of the research question. Separate mapped observations, model-derived quantities and proposed process explanations. Explain the lack of an independently estimated climate residual or causal partition.]

Detailed code, parameter tables and audits are reserved for the [appendix](appendix.md). The main comparisons follow in [Results](results.md).
