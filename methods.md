(methods)=
# Methods: building a defensible comparison

We first measure how the mapped glacier footprints and fronts changed, then compare the spatial settings of Brown and Stephenson. Modelled terrain and archived field observations add evidence about the lower glaciers and lagoon basin. Python and GIS connect these datasets through reproducible preparation, spatial sampling, validation and exports to the interactive map.

(workflow)=
## From observations to interpretation

The workflow combines three strands: **mapped change**, **spatial setting** and **archived field evidence**. Each contributes a different part of the comparison. Shared checks preserve observation dates, valid-data coverage and the distinction between measured and modelled quantities.

:::{figure} Figures/Book/02_analysis_workflow.png
:label: fig-methods-workflow
:alt: Three evidence strands showing mapped glacier change, spatial setting and archived field reconstruction, joined through shared checks into synthesis and the interactive explorer.
:width: 100%
:align: center

Analytical workflow for the Brown–Stephenson comparison. Historical outlines and satellite radar establish mapped change; geological, terrain and velocity layers describe spatial setting; archived radar sections and lagoon soundings provide local field evidence. Date, coverage and sensitivity checks guide their integration. The resulting interpretation distinguishes observations, model-derived estimates and proposed mechanisms.
:::

GeoPandas and Shapely handle vector geometry; GDAL, rasterio and rioxarray prepare rasters; xarray organises the velocity time series; and NumPy, SciPy and scikit-image support numerical analysis and segmentation. Prepared layers and summaries are exported for the book and interactive explorer. Complete code remains in the notebooks used to produce this report, with short excerpts below showing consequential decisions.

(data-overview)=
### Data, dates and spatial support

All metric analysis uses **WGS 84 / UTM zone 43S (EPSG:32743)**. Layers are aligned for each calculation rather than forced onto one universal grid. Changing a grid's spacing does not increase the information in the source observations.

| Evidence | Observation period and working support | Role |
| --- | --- | --- |
| Glacier outlines | 1947, 1988 and 2014 inventories; project-derived 2019 and 2026 outlines | Mapped area and front change |
| Sentinel-1 radar | April 2019 and April 2026; shared 10 m output grid | Recent boundary delineation |
| Surface DEM | RADARSAT 2002 product, including 1997 input; native 10 m grid | Surface terrain and common elevation context |
| Modelled thickness and error | Product representative of approximately 2010–2020; aligned 50 m grid | Estimated bed beneath valid ice pixels |
| ITS_LIVE velocity | Retained 2016–2022 image pairs; 120 m grid within 2014 glacier footprints | Flow speed, direction and coverage |
| Geological polygons | Supplied geological map, attributed in the project source register to Fox et al. (2023) | Mapped surface materials and retreat-zone composition |
| Field archives | Brown radar observations from 2000 and 2004; 2004 lagoon soundings | Local bed comparisons and supported lagoon reconstruction |

The 2019 inventory supplies the reporting footprint for thickness and bed summaries, while velocity uses the 2014 footprint. Terrain comparisons retain the older DEM as a common spatial context. These choices support consistent comparisons within each analysis, but the layers do not represent simultaneous glacier conditions.

% PRESENTATION CUE — Griffin, 0:30–1:10: introduce the three evidence strands and Python/GIS integration; explain why observation dates and sampling footprints differ.

(methods-outlines)=
## Reconstructing outlines and measuring retreat

### Coherence provides the boundary evidence

Initial inspection showed that radar brightness alone did not reliably separate ice from surrounding terrain. We therefore used **interferometric coherence**, which measures the similarity of radar signals between acquisitions, as the main segmentation input. Low coherence can accompany changing ice surfaces, but also water and other surface changes; it does not uniquely identify glacier ice.

Matched Sentinel-1A IW HH acquisitions came from ascending relative orbit 100. Backscatter dates were **13 April 2019** and **12 April 2026**; the coherence pairs spanned **1–13 April 2019** and **31 March–12 April 2026**. Copernicus processing supplied coherence, terrain-corrected backscatter and observation masks. The shared output grid had 10 m spacing.

:::{figure} Figures/Inventory_methods_SAR_evidence.png
:label: fig-methods-sar
:alt: Sentinel-1 coherence in the left column and HH backscatter in the right column, for 2019 above and 2026 below, with 2014 glacier outlines.
:width: 100%
:align: center

Radar evidence used during outline development. Rows show 2019 and 2026; columns show 12-day HH coherence and HH backscatter. Cyan boundaries mark the supplied 2014 inventory. Coherence guides segmentation, while backscatter supports visual inspection. Backscatter display ranges are adjusted separately for each year and should not be read as a shared radiometric scale. Source imagery: Copernicus Sentinel-1.
:::

A normalised Gaussian filter with 30 m standard deviation reduces local coherence variation, and a Sobel gradient highlights changes between neighbouring regions. Marker-controlled watershed then separates regions growing from ice and stable-terrain seeds (scikit-image contributors, n.d.). Ice seeds require smoothed coherence ≤0.22 and locations at least 200 m inside the 2014 footprint; stable-terrain seeds require coherence ≥0.45. These thresholds select starting points rather than directly defining the final boundary.

### Mapping constraints are part of the result

The accepted outlines exclude mapped lagoons and use valid radar observations outside the high-elevation override. The 2019 candidates are restricted to the 2014 footprint, and 2026 is restricted to the accepted 2019 footprint. **Advance beyond an earlier footprint is therefore excluded** Ice strictly above 1,000 m inherits the 2014 extent because initial segmentation produced implausible internal gaps. That upper-glacier stability is imposed, rather than independently observed.

Final vector outlines were reviewed for Brown and Stephenson and saved separately from intermediate classifications. Recent outlines elsewhere on the island remain provisional. Below the elevation cutoff, gaps caused by missing observations, radar shadow or unresolved classification must not automatically be interpreted as retreat. The 10 m grid is a processing choice, and no independent outline-accuracy estimate has been established.

### Area loss and front displacement

Historical geometries are matched to the glacier catalogue, repaired where necessary and measured in the projected CRS. Unmatched historical features remain in the audit rather than being assigned speculatively. Cumulative percentage loss uses 1947 area as its baseline; interval percentage loss uses the area at the start of that interval. Dividing by elapsed years gives an interval-average rate, not separately observed annual changes.

Front change is measured along fixed routes running from seaward origins towards the surviving inland ice. For each dated outline, the front is the seaward end of the transect segment connected to the inland endpoint; detached ice patches are excluded. This is **transect retreat**, whose value depends on route and glacier geometry (Lea et al., 2014). It is distinct from area loss and from the speed of ice moving through the glacier.

% PRESENTATION CUE — James, 1:10–2:20: explain coherence and seeded segmentation, then the elevation and no-advance constraints; distinguish area loss from transect retreat.

(methods-terrain)=
## Estimating the bed and examining glacier geometry

:::{figure} Figures/Book/crevasse.jpg
:label: fig-field-crevasse
:alt: Archived field photograph titled Crevasse.
:width: 70%
:align: center

*Crevasse.* Field photograph from the 2003–2004 Heard Island campaign archive (Allison & Thost, 2010).
:::

### Aligned subtraction, with missing values preserved

The surface DEM combines 2002 radar-derived elevations with a 1997 stereoscopic DEM (Brolsma & Smith, 2008). Modelled ice thickness and its error layer come from Millan et al. (2021). Surface elevation is averaged onto a common 50 m grid; thickness and error use nearest-neighbour resampling. Estimated bed elevation is then:

$$
z_{\mathrm{bed}} = z_{\mathrm{surface}} - H.
$$

The following excerpt from the geomorphology workflow preserves the land and lagoon masks before subtraction:

```python
# Exclude mapped lagoons; missing thickness remains NaN.
thickness_land_50m = np.where(
    land_mask & ~lagoon_mask, thickness_raw_50m, np.nan)

# Missing thickness produces missing bed elevation, not exposed land.
bed_candidate_50m = surface_50m - thickness_land_50m
```

Only valid surface elevations and positive modelled thickness contribute bed estimates. Negative bed elevations are retained. Isolated thickness anomalies are flagged and remain visible in the accepted, unsmoothed candidate product. Changing the outline mask does not turn this fixed thickness model into separate thickness observations for 2019 and 2026.

:::{figure} Figures/Brown_Stephenson_thickness_and_bed.png
:label: fig-methods-terrain
:alt: Brown and Stephenson maps comparing modelled thickness and estimated bed elevation within their 2019 reporting footprints.
:width: 100%
:align: center

Modelled ice thickness and estimated bed elevation for Brown and Stephenson. Rows identify the glaciers; columns show thickness and bed elevation, with shared scales for each quantity. Estimates use the aligned 50 m inputs and the 2019 reporting footprint, excluding mapped lagoons. Grey hillshade provides surface context and does not fill missing bed estimates. Sources: Brolsma and Smith (2008); Millan et al. (2021).
:::

The input dates differ, and the supplied thickness errors do not include every source of uncertainty in the derived bed. Their glacier-wide mean is a summary of reported pixel errors, not a confidence interval for mean thickness. The thickness model also uses ice-motion information (Millan et al., 2022), so correspondence between modelled bed and flow is not fully independent validation.

(methods-transects)=
### Sampling profiles and screening possible bed highs

:::{figure} Figures/09_Synthesis/04a_transect_locations.png
:label: fig-methods-transects
:alt: Brown and Stephenson glacier outlines, fixed analysis transects with numbered distance stations, and 2004 lagoon sounding locations.
:width: 100%
:align: center

Selected analysis routes and field coverage. White lines run inland from each route's seaward origin; numbered stations show distance in kilometres. Yellow points locate 2004 lagoon soundings rather than lagoon boundaries. Brown's route links the surveyed lagoon and surviving glacier; Stephenson's curves between its former southern tongue and remaining northern tongue. The panels use different map scales. Coordinates are in EPSG:32743.
:::

Raster values are sampled every 50 m at five positions across a 200 m corridor. Each native cell is counted once per station, and missing centreline values remain gaps. Modelled bed is restricted to the 2019 footprint and displayed with a three-station rolling median. Perpendicular intersections measure connected **ice-footprint width**, rather than bedrock valley width. Area below 300, 600 and 900 m is counted using the same DEM for every outline; this tracks footprint occupation of low terrain, not historical surface lowering.

Potential bed highs require at least 10 m prominence and 300 m separation. Seven checks vary smoothing, shift profiles 100 m to either side, and apply four smooth thickness perturbations using the reported error magnitude. A nearby peak must remain within 150 m; unsupported checks remain unassessed. Persistence counts describe sensitivity to these choices, not the probability of a pinning point. Cross-sections help inspect lateral form but cannot establish a continuous valley-wide barrier where coverage is incomplete.

(methods-field)=
## Recovering radar sections and lagoon depths

### Registration and vertical references

Archived field observations provide local comparisons with the modelled terrain (Allison & Thost, 2010). Workbook radar-return proxies and archived interpreted bed envelopes are retained as distinct products. The envelopes are the original analysts' interpretations, rather than additional independent soundings.

Archived section coordinates are registered to projected survey positions, with scale and residual checks recorded. BG35 requires a substantial scale adjustment and contains placeholder antenna coordinates. It remains visible as provisional evidence and is excluded from primary interpreted-bed metrics. A close registration fit alone does not resolve its geometry problem.

The radar elevations already follow the archive's approximate sea-level convention. Nearby ellipsoidal GPS heights differ by approximately 40 m, consistent with the documented conversion; subtracting another 40 m from the radar sections would apply it twice. Lagoon depths have a separate reference: **the 2004 water surface**, whose absolute elevation remains unresolved. The reconstructions are therefore compared with explicit datum labels and illustrative water-level scenarios, rather than merged into a continuous absolute-elevation bed.

### Interpolation where observations support it

:::{figure} Figures/Book/elevated_science.jpg
:label: fig-field-elevated-science
:alt: Archived field photograph titled Elevated Science.
:width: 70%
:align: center

*Elevated Science.* Field photograph from the 2003–2004 Heard Island campaign archive (Allison & Thost, 2010).
:::

Brown has 211 retained 2004 lagoon soundings; Stephenson has 16. The detailed basin reconstruction is restricted to Brown. Delaunay triangulation connects observations, and linear interpolation estimates depth inside those triangles (SciPy community, n.d.). Triangles are rejected if their longest edge exceeds 150 m or they intersect the retained surveyed-margin barrier. Predictions must also lie within 100 m of a sounding. No extrapolation is made outside the triangulation.

This excerpt from the field data reconstruction workflow shows the support rules:

```python
# Reject long triangles and triangles crossing the surveyed margin.
accepted_triangles = (maximum_edges <= maximum_edge_m) & ~crosses_shore

# Inside evaluate(): retain accepted triangles close to observations.
usable[inside] = accepted_triangles[simplex[inside]]
usable &= nearest <= reconstruction_settings["bathy_max_nearest_sounding_m"]
values[~usable] = np.nan
```

The 10 m raster samples the interpolated surface; it does not imply a 10 m measurement resolution. The 3D mesh follows accepted support, leaving gaps visible rather than extending across unsurveyed parts of the lagoon.

:::{figure} Figures/06_Brown_lagoon_bathymetry_QA.png
:label: fig-methods-lagoon-qa
:alt: Brown Lagoon interpolated depths and sounding locations, distance to the nearest sounding, and supported spatial block holdout residuals.
:width: 100%
:align: center

Brown Lagoon reconstruction and support checks. The left panel shows interpolated depth below the 2004 water surface, soundings and retained December 2003 margin-track segments. The centre panel shows distance to the nearest sounding within accepted support. The right panel shows residuals from 100 m block holdout: positive values indicate predictions deeper than observations. Hollow symbols identify soundings without supported held-out predictions. Source: Allison and Thost (2010).
:::

Validation withholds all observations in each 100 m spatial block and rebuilds the interpolator from the remainder. Bias, mean absolute error and RMSE are reported alongside the fraction of held-out points that receive supported predictions. Triangle-edge limits of 100, 150 and 200 m test the coverage choices. Lower error on a much smaller supported subset does not establish a better reconstruction of the whole basin. Supported depths and depth-area totals describe the surveyed portion, without establishing the complete lagoon boundary, basin volume or connecting sill.

% PRESENTATION CUE — Griffin, 2:20–4:15: explain surface-minus-thickness and its uncertainty, then radar registration, the two vertical references, lagoon support rules and spatial holdout validation. Keep detailed bed-high checks for questions.

(methods-geology)=
## Preparing geology and comparing retreat zones

James's geology workflow repairs source geometries, reprojects them to EPSG:32743 and clips them to the coastline. Original `Rock_Type` categories are retained, with missing labels recorded as Unknown. Projected polygon areas produce a unit-area summary. The percentages describe shares of the **summed clipped mapped polygon area**, rather than assuming complete geological coverage of the island.

The following excerpt from the geological analysis shows the clipping and area calculation:

```python
geo = geo.to_crs(TARGET_CRS)
geo = gpd.clip(geo, coastline)
geo = geo[~geo.geometry.is_empty].copy()
geo["Rock_Type"] = geo["Rock_Type"].fillna("Unknown")
geo["Area_km2"] = (geo.geometry.area / 1e6).round(3)
```

Clipping restricts the polygons to the study area; measuring them in a CRS with metre units makes the area calculation meaningful (GeoPandas developers, n.d.). This preparation supplies both the geology map and the later retreat-zone comparison.

:::{figure} Figures/Methods/03_mapped_geology_context.png
:label: fig-methods-geology
:alt: James's clipped Heard Island geology, with Brown and Stephenson located, beside the mapped area share of each geological category.
:width: 100%
:align: center

Mapped geological categories after James's preparation. The map retains source categories and locates the 2014 Brown and Stephenson footprints. Matching bar colours show each category's share of the summed clipped mapped polygon area; this denominator is not necessarily the island's full land area. Snow/Ice and Unknown labels are retained. Source attribution follows the project register: Fox et al. (2023); lecturer-supplied geological layer.
:::

Consecutive glacier polygons define gross spatial retreat zones. Intersecting these zones with geological polygons describes their mapped composition; the full zone area is the denominator, with uncovered area recorded as Unmapped. The overlay uses one geological map, rather than reconstructing surface materials independently at every inventory date.

**Snow/Ice does not identify the material beneath the glacier.** Likewise, mapped moraine identifies glacial deposits without establishing the substrate beneath former ice or the lagoon floor. We retain these distinctions instead of extending neighbouring units into unknown areas. The overlay supports statements about spatial association and mapped exposure; it cannot by itself demonstrate contrasting bed strength or erodibility.

(methods-surface-terrain)=
## Deriving surface hillshade, slope and aspect

James uses GDAL to derive three complementary layers from the clipped native 10 m surface DEM: **hillshade** simulates illumination to reveal relief; **slope** measures steepness in degrees; and **aspect** records the downslope direction clockwise from north (GDAL/OGR contributors, n.d.). Flat cells have undefined aspect and remain missing under the selected settings.

:::{figure} Figures/Methods/04_surface_terrain_derivatives.png
:label: fig-methods-surface-terrain
:alt: Heard Island surface DEM hillshade, slope in degrees and aspect clockwise from north, with 2019 glacier outlines.
:width: 100%
:align: center

Surface terrain derivatives from James's GDAL workflow. Panels show hillshade, slope and aspect calculated from the clipped RADARSAT 2002 DEM, which includes 1997 input. The 2019 outlines provide spatial context and do not date the elevation surface. Aspect is cyclic, with north at both 0° and 360°; flat or missing cells have no defined direction. Hillshade represents simulated illumination. DEM source: Brolsma and Smith (2008).
:::

These layers describe the recorded surface, including ice where present. They are distinct from derivatives of the modelled bed. DEM age, source artefacts and local missing data propagate into the derivatives, so apparent small features require care. Surface hillshade is a visual aid and does not measure radiation or melt.

% PRESENTATION CUE — James, 4:15–6:15: show the geological preparation and mapped categories, explain the area denominator and unknown substrate, then define hillshade, slope and aspect and distinguish surface terrain from modelled bed.

(methods-velocity)=
## Summarising flow with its retained coverage

ITS_LIVE Sentinel-1A image-pair velocities provide the 2016–2022 flow context (Lei et al., 2022). Pairs with separations of 10–180 days are selected from matching datacubes. At each pixel, valid positive vectors pass magnitude and direction filters: speeds must fall between one-third and three times the initial median, and directions must lie within 45° of the median vector. The median vector must exceed 10 m/year. Final pixels require at least five retained pairs and directional coherence ≥0.8.

Pixel speeds are the temporal median of retained magnitudes; glacier summaries use spatial medians of those pixels. The fixed 2014 footprint provides a consistent sampling boundary, including some locations that subsequently lost ice. The lower third refers to each glacier's DEM-derived elevation range, rather than its lower third by length.

:::{figure} Figures/07_velocity_focus_maps.png
:label: fig-methods-velocity
:alt: Brown and Stephenson filtered median ice-speed maps within their 2014 sampling footprints, with missing estimates visible.
:width: 100%
:align: center

Retained 2016–2022 ice-speed estimates for Brown and Stephenson within the 2014 sampling footprints. Both maps use the same speed scale. Gaps indicate missing or rejected estimates and do not establish stationary ice. The 120 m grid does not imply an equivalent effective observation resolution. Source: ITS_LIVE Sentinel-1 image-pair velocities (Lei et al., 2022).
:::

Coverage is reported relative to footprint grid cells, with a separate retention measure relative to cells having raw observations. Lower-third audits, speed-floor and minimum-pair sensitivity tests, supplied pair errors and year-balanced summaries assess selection effects. In particular, the 10 m/year rule removes slow flow by design. Supplied pair errors are not confidence intervals for pooled glacier medians, and unequal coverage limits direct comparisons.

(methods-solar)=
### A geometric summer-exposure index

Surface slope and aspect are summarised onto the 120 m grid; aspect is aggregated through sine and cosine because compass directions wrap at north. The index samples hourly solar geometry at 53.1°S on four representative November–February dates. Positive projections onto the surface normal are summed during daylight and divided by the corresponding sum for a horizontal surface. Nearly flat cells are assigned one, while cells with strongly mixed aspects are excluded. The solar approximation follows Cooper (1969), with projection geometry described by Iqbal (1983).

Values above or below one describe greater or smaller geometric exposure than a horizontal surface. The index excludes clouds, albedo, atmospheric attenuation, diffuse radiation and shadows cast by surrounding terrain. Topographic shading can materially alter glacier radiation (Olson & Rupper, 2019), so this restricted index is interpreted as an orientation comparison rather than measured radiation, an energy balance or a melt estimate.

% PRESENTATION CUE — Griffin, 6:15–7:00: summarise velocity filtering and unequal coverage; explain that missing speed is not zero, and that the exposure index measures geometry rather than melt.

(methods-synthesis)=
## Bringing the evidence together

The synthesis distinguishes **mapped observations**, **model-derived quantities** and **proposed mechanisms**. Agreement among layers can strengthen an observational narrative, but shared model inputs, different dates and incomplete coverage limit independence. We do not calculate an independently estimated climate residual or partition the causes of retreat. Instead, the comparison identifies supported spatial contrasts and the targeted observations needed to test possible explanations.

Detailed parameter records, code and audits belong in the [appendix](appendix.md). Full source entries are consolidated on the [References](references.md) page. The principal comparisons follow in [Results](results.md).
