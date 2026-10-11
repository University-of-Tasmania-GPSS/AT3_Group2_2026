(appendix)=
# Supporting evidence and reproducibility

This appendix records the definitions, processing settings and checks behind the Brown–Stephenson comparison. The tables retain sampling boundaries, units and error conventions so that the principal results can be traced without treating every mapped layer as a simultaneous observation. The [Methods](methods.md) explain the analytical choices; the [Results](results.md) and [Discussion](discussion.md) develop their interpretation.

Values are rounded for display. Rates and percentages were calculated from the original numerical outputs, rather than from the rounded areas shown here. Missing estimates remain unavailable; they are not assigned zero.

[List of figures](#appendix-figures) · [Lower-third filter audit](#lower-third-filter-audit)

(appendix-inventory)=
## A. Inventory matching and retreat measurements

:::{dropdown} Identity, dates and mapping scope

The 2014 inventory supplies the glacier catalogue: Brown is **RGI60-19.00023** and Stephenson is **RGI60-19.00005**. Historical outline fragments are matched to those identities before dissolution and projected area measurement. An accepted historical record is a source feature, rather than necessarily an entire glacier. Several accepted fragments can therefore contribute to one named glacier.


Unmatched records remain in the matching audit and are excluded from the named-glacier histories. Rock records are handled separately. These counts describe the historical matching exercise across the inventory, not the number of Brown and Stephenson outlines.

The supplied historical outlines are credited to Donoghue and Harris (2021). The project-derived recent outlines use April 2019 and April 2026 radar evidence. Their backscatter dates are 13 April 2019 and 12 April 2026; their coherence pairs span 1–13 April 2019 and 31 March–12 April 2026. The annual labels identify inventory years, rather than implying identical acquisition dates or seasons for every source.

Recent mapping imposes three consequential constraints:

- The 2019 outline is restricted to the 2014 footprint, and the 2026 outline is restricted to the accepted 2019 footprint. Advance outside an earlier boundary is excluded by construction.
- Ice strictly above 1,000 m inherits the 2014 extent. Apparent upper-glacier stability is therefore imposed.
- Mapped lagoons are excluded. Missing radar observations, shadow and unresolved classification require inspection rather than automatic interpretation as ice loss.

Brown and Stephenson received the final boundary review used for the accepted comparison. Recent outlines elsewhere on the island provide provisional context. A 10 m processing grid does not establish a 10 m boundary accuracy.
:::

| Historical inventory | Accepted ice records | Unmatched ice records |
| --- | ---: | ---: |
| 1947 | 45 | 4 |
| 1988 | 26 | 4 |


:::{dropdown} Mapped area and interval loss

Between 1947 and 2026, mapped area decreased by **40.44% at Brown** and **68.49% at Stephenson**, using each glacier's 1947 area as its denominator. Interval percentages instead use the area at the beginning of each interval.


Annualised values are interval averages using the labelled year differences. They do not describe separately observed annual changes or compound percentage rates. The synthesis also retains a proportional rate normalised to the fixed 1947 area, allowing the effect of changing denominators to be inspected.

Spatial retreat zones are calculated as the earlier polygon minus the later polygon. Gross loss, mapped gain and net area change are retained separately: a gross retreat-zone area need not equal net loss where historical boundaries differ locally.
:::

| Inventory year | Brown area (km²) | Stephenson area (km²) |
| --- | ---: | ---: |
| 1947 | 5.357 | 25.846 |
| 1988 | 4.277 | 20.520 |
| 2014 | 3.404 | 9.227 |
| 2019 | 3.333 | 8.376 |
| 2026 | 3.191 | 8.143 |


| Glacier | Interval | Years | Area lost (km²) | Loss per year (km²/year) | Loss per year (% of interval-start area) |
| --- | --- | ---: | ---: | ---: | ---: |
| Brown | 1947–1988 | 41 | 1.081 | 0.026 | 0.492 |
| Brown | 1988–2014 | 26 | 0.873 | 0.034 | 0.785 |
| Brown | 2014–2019 | 5 | 0.071 | 0.014 | 0.415 |
| Brown | 2019–2026 | 7 | 0.142 | 0.020 | 0.610 |
| Stephenson | 1947–1988 | 41 | 5.325 | 0.130 | 0.503 |
| Stephenson | 1988–2014 | 26 | 11.293 | 0.434 | 2.117 |
| Stephenson | 2014–2019 | 5 | 0.851 | 0.170 | 1.845 |
| Stephenson | 2019–2026 | 7 | 0.233 | 0.033 | 0.397 |


:::{dropdown} Front position along a fixed route

The front is the seaward end of the transect intersection connected to its inland endpoint. Detached ice patches do not define that front. Distance increases inland from a fixed seaward origin, and positive displacement indicates retreat along the selected route.


These route-dependent front rates describe a different quantity from area loss or ice-flow speed. Changing width and lateral boundary position can change the relationship between retreat distance and area removed.
:::

| Interval | Brown front retreat (m/year) | Stephenson front retreat (m/year) |
| --- | ---: | ---: |
| 2014–2019 | 19.09 | 61.31 |
| 2019–2026 | 11.90 | 103.48 |


(appendix-geology)=
## B. Geological preparation and retreat-zone overlays

:::{dropdown} Repair, clipping and category areas

James's geology workflow reads the supplied polygons, repairs unclosed rings where possible and removes unavailable geometries before clipping. The saved read audit reports **two source geometries that could not be repaired**. Remaining geology is projected to EPSG:32743 and clipped to the coastline. The shapefile export retains polygon components; the recorded export contains 1,507 polygons.

The following table preserves the original `Rock_Type` labels. The denominator is the **sum of clipped mapped polygon areas**, calculated before display rounding. It is not an independently measured island land area or a guarantee of complete, non-overlapping coverage.


Small values can round to 0.00 without being absent. The source spellings “Uncosolidated” are retained here for traceability; figure labels use “Unconsolidated”. Missing source labels are recorded as Unknown. Attribution follows the project source register, which identifies Fox et al. (2023); the supplied layer's provenance should be read alongside the consolidated [data credits](references.md).
:::

| Source category | Mapped polygon area (km²) | Share of summed mapped area (%) |
| --- | ---: | ---: |
| Snow/Ice | 219.90 | 63.22 |
| Moraine | 55.46 | 15.94 |
| Uncosolidated Glacial Sediments | 22.10 | 6.35 |
| BBS - Basalt | 16.35 | 4.70 |
| Cone | 10.70 | 3.08 |
| LPS | 8.48 | 2.44 |
| LPS - Trachyte | 3.85 | 1.11 |
| LPS - Basanite | 3.00 | 0.86 |
| Drygalski Formation | 2.89 | 0.83 |
| Recent Lava Flow | 2.12 | 0.61 |
| Uncosolidated Beach Deposit | 2.04 | 0.59 |
| Tephra | 0.29 | 0.08 |
| Cone Lava | 0.24 | 0.07 |
| Crater | 0.18 | 0.05 |
| Laurens Peninsula Limestone | 0.13 | 0.04 |
| LPS - Tephrite | 0.05 | 0.01 |
| Ash | 0.02 | 0.00 |
| BBS - Trachyte | 0.02 | 0.01 |
| Ice | 0.00 | 0.00 |


:::{dropdown} Composition of the retreat zones

The synthesis intersects each glacier's gross retreat zones and remaining 2026 footprint with these polygons. Category share is calculated against the **entire zone area**, including any uncovered area recorded as Unmapped. A union-area check tests for overlapping geology within each zone and stops the calculation if excess overlap exceeds 0.000001 km².

This differs from the island category table above: the zone analysis explicitly accounts for unmapped area and checks local overlaps. In the recent retreat zones, the source map's Snow/Ice class occupies more than 99.9%. That category leaves buried substrate unresolved. Likewise, Moraine identifies a mapped deposit without measuring the material, strength or erodibility beneath former ice or the lagoon floor.

The full category-by-zone records are exported as `geology_by_retreat_zone.csv`, with glacier, zone, original category, intersected area and percentage fields. The overlay describes association with one source map; it does not reconstruct geological exposure at every inventory date.
:::

(appendix-terrain)=
## C. Surface terrain, modelled thickness and bed uncertainty

:::{dropdown} Grids and derivative settings

The RADARSAT 2002 DEM includes a 1997 stereoscopic contribution (Brolsma & Smith, 2008). James's surface derivatives use its clipped native 10 m grid. The modelled-bed calculation instead uses an aligned 50 m grid, with surface elevation averaged to that grid and thickness and error resampled by nearest neighbour. Velocity and exposure calculations use a separate 120 m grid.


The derivative algorithm is left at GDAL's default in the saved functions. Hillshade depicts simulated illumination, while slope and aspect describe the selected elevation surface. Bed derivatives inherit the uncertainty of the subtraction; they are not additional bed observations.

This shortened excerpt retains the consequential settings from the geomorphology workflow:

```python
slope_options = gdal.DEMProcessingOptions(
    slopeFormat = "degree", computeEdges = True)
aspect_options = gdal.DEMProcessingOptions(
    zeroForFlat = False, computeEdges = True)
shade_options = gdal.DEMProcessingOptions(
    azimuth = 315, altitude = 45, zFactor = 1.0,
    multiDirectional = False, combined = False,
    computeEdges = True)
```
:::

| Setting | Surface derivatives | Modelled-bed derivatives |
| --- | --- | --- |
| Input | Clipped surface DEM | Surface elevation minus valid modelled thickness |
| Grid spacing | 10 m | 50 m |
| Analysis CRS | EPSG:32743 | EPSG:32743 |
| Slope | Degrees | Degrees |
| Aspect | Clockwise from north; flat cells NoData | Same convention |
| Hillshade light | Azimuth 315°; altitude 45° | Same lighting |
| Hillshade vertical factor | 1.0 | 1.0 |
| Edge computation | Enabled | Enabled |
| Multidirectional / combined hillshade | Both disabled | Both disabled |


:::{dropdown} Thickness support within the 2019 reporting footprints

Modelled thickness and its supplied error come from Millan et al. (2021). Mapped lagoons are excluded, missing thickness remains unknown, and negative estimated bed elevations are retained. Year-specific masks do not create separate thickness measurements for those years.


Coverage uses the grid cells assigned to each 2019 reporting footprint. Error coverage, retained in the full export, uses valid thickness cells as its denominator. The mean supplied error summarises source pixel errors; it is not uncertainty in the glacier-wide mean and does not incorporate DEM error, input-date mismatch or all bed-estimation uncertainty.

Across the island, four isolated thickness jumps were flagged for review. None falls within these two reporting footprints. Flagged values remain in the accepted unsmoothed candidate product; the flags document inspection rather than silently removing anomalies.
:::

| Glacier | Thickness / bed coverage (%) | Mean thickness (m) | Median thickness (m) | Mean supplied thickness error (m) | Flagged spike cells |
| --- | ---: | ---: | ---: | ---: | ---: |
| Brown | 99.40 / 99.40 | 115.71 | 127.02 | 45.67 | 0 |
| Stephenson | 99.85 / 99.85 | 109.65 | 116.47 | 44.67 | 0 |


:::{dropdown} Radar registration and local bed comparisons

The field reconstruction workflow retains workbook return proxies separately from the original analysts' interpreted 2000 bed envelopes (Allison & Thost, 2010). The latter are registered from archive chainage to survey coordinates. Scale and horizontal residuals test coordinate consistency.


BG35's archive includes two placeholder antenna coordinates. Reproducing the saved processing geometry gives a map/archive scale approximately 13.8% above unity. Its small registration residual does not resolve that problem, so its envelope remains provisional. Near-zero residuals for the other sections also do not establish bed accuracy, particularly where controls are few.

Interpreted sections are sampled at approximately 25 m spacing, then grouped by unique 50 m model cell. Each cell contributes once to the summary, using the median interpreted bed height sampled within it. This prevents dense digitised vertices from being counted as independent model comparisons.


Difference is **modelled bed minus interpreted field bed**: negative bias places the modelled bed lower. The eligible sections sample only two or three model cells each and show different biases, providing local consistency checks rather than glacier-wide validation or a common correction to the bed raster.

The separate workbook-return comparison retains the source-labelled W and E returns. Its model-minus-field thickness biases range from approximately +63 to +95 m, while surface-elevation biases are smaller, approximately +3 to +10 m. These proxies, the recovered envelopes and model estimates differ in date and interpretation; they must not be pooled as interchangeable measurements.
:::

| Section | Registration controls | Map/archive length scale | Registration RMSE (m) | Primary interpreted-bed metrics? |
| --- | ---: | ---: | ---: | --- |
| BG30 | 2 | 1.0000 | 0.0000 | Yes |
| BG35 | 35 | 1.1379 | 0.0538 | No; provisional geometry |
| BG45 | 3 | 1.0000 | 0.0002 | Yes |
| BG50 | 4 | 1.0000 | 0.0088 | Yes |


| Section | Unique model cells | Mean bed difference (m) | MAE (m) | RMSE (m) | Use |
| --- | ---: | ---: | ---: | ---: | --- |
| BG30 | 2 | −61.78 | 61.78 | 62.07 | Primary |
| BG45 | 2 | −24.89 | 24.89 | 25.54 | Primary |
| BG50 | 3 | +6.29 | 7.82 | 10.46 | Primary |
| BG35 | 24 | −26.70 | 53.06 | 66.75 | Descriptive only |


(appendix-bed-highs)=
:::{dropdown} Screened bed highs and persistence

The screened bed highs are shown in [](#fig-appendix-bed-highs). Profiles are sampled every 50 m at lateral offsets of −100, −50, 0, +50 and +100 m. Native model cells are counted once per station, and a missing centreline sample remains a gap. A three-station rolling median requires a complete window, so it cannot bridge missing stations. Peaks require at least 10 m prominence and 300 m separation within continuous support.

Seven deterministic checks use a five-station median, profiles displaced 100 m to either side, and four smooth thickness perturbations with 1 km wavelength and different phases. Their amplitudes use the supplied thickness-error magnitude. A check retains a feature when a selected peak lies within 150 m of its original position; checks lacking local support remain unassessed.




None persists through every assessable check. Ice motion contributes to the thickness model (Millan et al., 2022), which limits the independence of any apparent correspondence between bed shape and the velocity layer.
:::

| Candidate | Distance inland along route (km) | Checks retaining a nearby high | Qualification |
| --- | ---: | --- | --- |
| Brown B1 | 2.50 | 4 of 7 | No retained velocity at the candidate; absent from the +100 m profile |
| Brown B2 | 4.10 | 5 of 7 | Local rise in the cross-section; absent from the +100 m profile |
| Stephenson S1 | 6.60 | 4 of 6 | +100 m check unsupported; stronger smoothing removes the selected peak |
| Stephenson S2 | 9.10 | 3 of 7 | Absent from both displaced profiles |


:::{figure} Figures/09_Synthesis/04c_candidate_bed_highs.png
:label: fig-appendix-bed-highs
:alt: Smoothed modelled bed profiles for Brown and Stephenson, with four candidate highs labelled by the number of supported sensitivity checks retaining a nearby peak.
:width: 100%
:align: center

<span class="evidence-badge evidence-modelled">Modelled</span>

Screened highs along the selected routes. Coloured lines show the three-station median bed profile; markers locate selected peaks. Labels count assessable checks retaining a peak within 150 m. S1 has six assessable checks because one displaced profile lacks support. Distances use each route's seaward origin, and panels have different elevation scales. These are candidate model features, with persistence counts rather than probabilities of real pinning points. Inputs: Brolsma and Smith (2008); Millan et al. (2021).
:::

(appendix-cross-sections)=
:::{dropdown} Cross-sections and lateral support

In [](#fig-appendix-cross-sections), Brown B2 forms a local rise near the main route, with lower modelled elevations on either side. At Stephenson S1, limited bed coverage on one side prevents assessment of a broader ridge. S2 provides no clear cross-section evidence of a continuous barrier. These sections identify locations for independent bed measurements; they do not establish valley-wide sills or observed front stabilisation.

Mapped corridor width elsewhere in the analysis comes from connected ice-polygon intersections. It measures glacier footprint width rather than a surveyed bedrock valley.
:::

:::{figure} Figures/09_Synthesis/04d_glacier_cross_sections.png
:label: fig-appendix-cross-sections
:alt: Six perpendicular sections comparing the 2002 surface and supported modelled bed near recent fronts, Brown B2, and Stephenson S1 and S2, with missing bed segments left blank.
:width: 100%
:align: center

<span class="evidence-badge evidence-modelled">Modelled</span>

Perpendicular sections through surface and modelled bed. Columns identify glaciers; rows show sections 250 m inland of the 2026 front, selected candidate highs, and additional comparison positions. Titles give inland route distance. Horizontal axes measure metres from the main route, marked at zero; vertical axes show elevation in metres and differ between panels. White lines show the 2002 surface and dashed coloured lines the supported modelled bed. Blank segments retain missing coverage, and the figure has no uncertainty band. Inputs: Brolsma and Smith (2008); Millan et al. (2021).
:::

(appendix-field)=
## D. Lagoon soundings, interpolation and vertical references

:::{dropdown} Observations and support rules

The 2004 archive provides **211 usable Brown soundings**, with a deepest measured depth of **56 m**, and **16 Stephenson soundings**, with a deepest measured depth of **107 m** (Allison & Thost, 2010). These are sampled depths, not established maximum depths of either complete lagoon. Brown's 20 soundings from 2000 remain a separate historical layer and are not mixed into the 2004 surface.

The Brown reconstruction uses linear interpolation within a Delaunay triangulation. Its primary support rules retain triangles with maximum edge length 150 m, reject triangles crossing retained December 2003 margin-track segments, and mask predictions more than 100 m from a sounding. The output grid is 10 m. The surveyed margin is an open track, split at steps exceeding 25 m; it is not closed into a lagoon boundary or assigned artificial zero depths.

The raster, contours, 3D mesh and water-plane display preserve support gaps. An interpolation edge indicates the extent of accepted numerical support, not an observed shoreline.
:::

:::{dropdown} Spatial block validation and support sensitivity

All observations in each occupied 100 m spatial block are withheld together. The interpolator and its support are rebuilt without those observations. A held-out point contributes to error metrics only if that reconstruction can predict it under the same support rules.


Residual is **predicted depth minus measured depth**. Negative bias therefore means shallower predictions. The primary setting leaves **92 held-out soundings unsupported**; those points are not extrapolated or assigned zero error.

The smaller RMSE at 100 m applies to only 14 supported points, so it does not establish better reconstruction of the whole basin. The 200 m limit increases mapped support only slightly, while supporting more held-out predictions. Values on shared full-data support did not change in this edge-limit test. These checks describe interpolation behaviour in the evaluated subset, rather than a confidence interval for unsurveyed areas or sounder calibration.
:::

| Maximum triangle edge (m) | Full-data supported area (km²) | Supported held-out points / 211 | Supported predictions (%) | Bias (m) | MAE (m) | RMSE (m) |
| --- | ---: | --- | ---: | ---: | ---: | ---: |
| 100 | 0.200 | 14 / 211 | 6.64 | −0.142 | 0.864 | 1.405 |
| **150 — primary** | **0.330** | **119 / 211** | **56.40** | **−1.948** | **2.953** | **4.470** |
| 200 | 0.337 | 162 / 211 | 76.78 | −1.815 | 3.128 | 4.817 |


:::{dropdown} Supported basin area and historical occupation

Depth thresholds are nested and use the supported raster area as their denominator. The overlap places the surveyed footprint within former glacier occupation and outside the 1988 outline. It does not date the formation of the entire lagoon, establish its complete area or justify a whole-lagoon volume estimate.
:::

| Quantity | Brown supported reconstruction |
| --- | ---: |
| Total supported raster area | 0.3301 km² |
| Area at least 30 m deep | 0.1519 km²; approximately 46% of support |
| Area at least 50 m deep | 0.0474 km²; approximately 14% of support |
| Maximum interpolated depth | Approximately 55.6 m |
| Overlap with mapped 1947 glacier footprint | 100% of supported area |
| Overlap with mapped 1988 and later glacier footprints | 0% of supported area |


:::{dropdown} GPS heights and water-level assumptions

The archive's approximate ellipsoid-minus-40 m convention is applied to shoreline GPS heights. Interpreted radar elevations already follow that convention and receive **no additional 40 m subtraction**.


The track provides shoreline and walking-route context, not a confirmed water-surface record. Its height distribution is consistent with a coastal setting but does not determine the lagoon level. This approximate conversion is not a site-specific geoid transformation or an error estimate.

Measured depth remains positive downward from the **2004 survey water surface**. For the illustrative absolute-elevation comparison:

$$
z_{\mathrm{lagoon\ bed}} = z_{\mathrm{assumed\ water}} - d_{\mathrm{survey}}.
$$

Assumed levels of 0, 2 and 5 m shift the lagoon-bed profile vertically without changing basin shape. They are sensitivity scenarios, not measured levels or uncertainty bounds. The deep surveyed basin remains below approximate sea-level zero in all three scenarios, while the terrain connecting it to the inland glacier remains unsampled. Radar samples within 100 m of the route are projected onto it for context; they are not exact on-route measurements. No continuous bed or connecting sill is reconstructed across the gap.
:::

| Shoreline-track statistic after approximate conversion | Value |
| --- | ---: |
| Usable positions | 581 |
| Median height | 0.64 m |
| Central half of heights | 0.61–1.00 m |
| Full height range | 0.12–9.10 m |


(appendix-velocity)=
## E. Velocity coverage and filtering sensitivity

:::{dropdown} Population represented by the speed summaries

ITS_LIVE provides 199 selected Sentinel-1A image pairs, with acquisition dates from 2 August 2016 to 29 December 2022, on a 120 m grid (Lei et al., 2022). Pair separations are restricted to 10–180 days. Each pixel's speed is the temporal median of retained magnitudes; glacier summaries are spatial medians of those pixel values.

The primary filters require finite positive vectors, magnitude between one-third and three times the initial pixel median, direction within 45° of the median vector, median-vector speed above 10 m/year, at least five retained pairs and vector coherence of at least 0.8. The lower third is the lowest third of each glacier's **DEM-derived elevation range**, not one-third of its area or length.


Retention coverage is retained cells divided by cells with at least one finite positive raw vector inside the sampling mask. All eligible cells in these focus-glacier masks had raw observations, so these percentages also equal their sampled-footprint fractions. In other populations, raw-observation retention and full-footprint coverage can differ. Missing or rejected cells are not assigned zero speed.
:::

| Glacier and sampling area | Cells with raw observations | Retained cells | Retention coverage (%) | Median speed (m/year) |
| --- | ---: | ---: | ---: | ---: |
| Brown — whole 2014 footprint | 238 | 154 | 64.71 | 207.68 |
| Brown — lower elevation third | 65 | 25 | 38.46 | 39.57 |
| Stephenson — whole 2014 footprint | 636 | 582 | 91.51 | 281.75 |
| Stephenson — lower elevation third | 370 | 316 | 85.41 | 266.52 |


(lower-third-filter-audit)=
:::{dropdown} Lower-third filter audit

At Brown, the speed floor removes 28 lower-third cells and the minimum-observation requirement removes another 12. Its published lower-third median therefore represents 25 cells, rather than all 65. The final vector-coherence step removes no additional Brown cells. These counts do not locate individual rejected cells or establish a spatial link to the candidate bed highs. Here, vector coherence describes consistency of the velocity vectors, rather than the interferometric coherence used for glacier-boundary mapping. See the [bed-control discussion](discussion.md#discussion-geology) for the proposed pinning-point interpretation. Stephenson retains a much larger share of its lower-glacier population.
:::

| Successive stage | Brown cells | Stephenson cells |
| --- | ---: | ---: |
| Eligible 2014 lower-third cells | 65 | 370 |
| Raw velocity observed | 65 | 370 |
| Magnitude filter | 65 | 370 |
| Median-vector speed above 10 m/year | 37 | 345 |
| Direction filter | 37 | 345 |
| At least five observations | 25 | 316 |
| Vector coherence | 25 | 316 |


:::{dropdown} Threshold sensitivity

The following trials change only the speed floor and minimum-pair count, retaining the other filtering rules. They do not replace the primary results.


Stephenson remains faster in every tested lower-third comparison, but Brown's retained population changes substantially. Relaxing thresholds increases coverage without demonstrating that every newly admitted estimate is accurate; selection and uncertainty remain part of the interpretation.
:::

| Vector-speed floor (m/year) | Minimum pairs | Brown retained cells | Brown median (m/year) | Stephenson retained cells | Stephenson median (m/year) |
| --- | ---: | ---: | ---: | ---: | ---: |
| **10 — primary** | **5** | **25** | **39.57** | **316** | **266.52** |
| 10 | 3 | 32 | 41.14 | 325 | 263.99 |
| 5 | 5 | 46 | 32.14 | 331 | 261.31 |
| 5 | 3 | 54 | 35.59 | 341 | 258.77 |
| 0 | 5 | 52 | 32.25 | 338 | 258.07 |
| 0 | 3 | 60 | 34.85 | 349 | 257.12 |


:::{dropdown} Supplied errors and unequal annual sampling

These summaries use supplied positive errors for accepted image-pair observations: pair errors and speed/error ratios are first summarised temporally at each pixel, then spatially. The ratio is not calculated by dividing the glacier's pooled median speed by its pooled median error. In particular, Brown's lower-third ratio below one highlights weak signal relative to the supplied pair-error context. These errors are not confidence intervals for the long-term pixel or glacier median.


The year-balanced estimate takes the median of each pixel's available annual medians for the six complete years. It reduces domination by years with more pairs, but it does not fill missing years or measure equal annual coverage. Monthly plots group interval-averaged pairs by midpoint and remain exploratory.
:::

| Sampling area | Brown median pair error (m/year) | Brown median speed/error ratio | Stephenson median pair error (m/year) | Stephenson median speed/error ratio |
| --- | ---: | ---: | ---: | ---: |
| Whole footprint | 88.5 | 2.29 | 95.0 | 2.98 |
| Lower third | 75.5 | 0.56 | 96.0 | 2.82 |


| Whole-footprint sampling check | Brown | Stephenson |
| --- | ---: | ---: |
| Primary median speed (m/year) | 207.68 | 281.75 |
| Year-balanced median, 2017–2022 (m/year) | 217.22 | 289.07 |
| Change from primary median (%) | +4.59 | +2.60 |
| Primary retained cells represented in all six years (%) | 52.6 | 92.1 |


(appendix-exposure)=
## F. Surface-exposure geometry

:::{dropdown} Calculating the orientation index

The orientation index uses DEM-derived slope and aspect on the 120 m grid. Aspect is averaged through sine and cosine, retaining its circular nature. Non-flat cells require aspect resultant strength of at least 0.5; cells with slope at most 1° receive an index of one. The comparison uses the 2014 footprints and, separately, their valid DEM cells below 600 m.

Solar geometry is sampled at latitude 53.1°S on day numbers 319, 349, 15 and 46, approximately mid-November through mid-February, with hourly angular steps. The calculation sums positive direct-beam projections while the Sun is above the horizon and divides by the corresponding horizontal-surface sum. The declination approximation follows Cooper (1969); the projection geometry follows Iqbal (1983). These dates and sampling choices are project approximations rather than a full seasonal integration.
:::

:::{dropdown} Index summaries and coverage

Valid index coverage exceeds 96% in all four comparisons. An index of one equals the geometric exposure of a horizontal surface under the sampled solar directions. Values above or below one describe the effect of orientation within this calculation, without measuring incident energy.
:::

| Sampling support | Brown median index | Stephenson median index |
| --- | ---: | ---: |
| Whole 2014 footprint | 1.028 | 0.983 |
| 2014 footprint below 600 m | 1.024 | 0.968 |


:::{dropdown} What the index leaves out

The index omits terrain-horizon shadows, clouds, atmospheric attenuation, diffuse radiation, albedo and debris effects. It is neither an energy balance nor a melt model. Brown's slightly higher orientation index does not reproduce the ranking of cumulative retreat, and no climate residual is calculated from it.
:::

(appendix-evidence)=
## G. Evidence limits and targeted observations

:::{dropdown} Evidence audit and interpretation

The strongest outcome is a spatially explicit observational narrative: the glaciers have different mapped histories and changing lower-tongue geometries, while Brown's field archive records a deep surveyed basin within former glacier occupation. Buried geology, continuous bed barriers and water-contact processes remain testable explanations. The current comparison does not assign their causal contributions or remove climate forcing from the retreat signal.
:::

| Evidence stream | Supported contribution | Main remaining limitation | Targeted observation or improvement |
| --- | --- | --- | --- |
| Glacier inventories | Contrasting mapped area and route-front histories | Different dates, outline uncertainty and imposed recent constraints | Independent outlines, repeated front observations and boundary-accuracy assessment |
| Geological map | Surface categories within mapped forelands and retreat zones | Buried substrate and mechanical properties unresolved | Ground observations, sediment samples and appropriate subsurface surveys |
| Surface terrain | Footprint occupation of one reference surface; slope and aspect context | Older DEM, source artefacts and no historical height reconstruction | Repeated high-quality elevation surveys with common vertical control |
| Modelled bed | Candidate geometry and locations worth investigating | Input-date mismatch, thickness uncertainty and shared velocity information | Independent radar coverage across and along candidate features |
| Archived radar | Registered local bed interpretations and model comparisons | Few independent model cells; BG35 geometry provisional | Resolve archive processing or acquire new georeferenced profiles |
| Lagoon reconstruction | Supported basin form and depths below the 2004 water surface | Incomplete survey support, unresolved absolute level and connecting terrain | Wider soundings, water-level control and a survey linking lagoon to glacier bed |
| Velocity | Retained flow contrast and explicit filtering sensitivity | Unequal coverage, slow-flow exclusion and substantial pair errors | Longer reliable time series and independent lower-glacier motion observations |
| Exposure index | Surface-orientation comparison | No atmospheric or surface energy balance | Radiation, shading and surface-condition observations within a physical energy-balance model |


(appendix-code)=
## H. Analysis code, provenance and reproduction

:::{dropdown} Workflow sources and dependencies

The linked source files preserve the complete processing code, decisions and export locations for each workflow.


Reproduction follows dependencies rather than relying on filename order alone:

1. Obtain the supplied inventories, coastline, geology, DEM, thickness tiles, field archives and SAR products, retaining original metadata and source versions. Prepare the clipped DEM before the elevation-constrained outline step.
2. Prepare and review the recent outlines, then create the named-glacier histories and fixed sampling footprints. Retain manual edits and the accepted outputs used for the final comparison.
3. Complete geological preparation and terrain/thickness exports. Field reconstruction and velocity analysis consume their respective inputs and common spatial context; complete the glacier-specific layer catalogues needed by the explorer.
4. Run integration and synthesis after its required tables, rasters and field metadata exist. This regenerates the combined comparisons and supplementary figures.
5. Build the interactive explorer from the accepted catalogue and outputs, then preview the book from the repository root.
:::

| Workflow source | Main role |
| --- | --- |
| [Data preparation](01_Data_Preparation.ipynb) | SAR evidence, segmentation, mapping constraints and accepted recent outlines |
| [Glacier retreat](02_Glacier_Retreat.ipynb) | Glacier identities, historical matching, area histories and animation preparation |
| [Geology analysis](03_Geology_Analysis_working.ipynb) | James's geological repair, clipping, category areas and mapped context |
| [Geomorphology](04_Geomorphology.ipynb) | Surface DEM preparation, James's surface derivatives, aligned thickness and estimated bed |
| [Sub-ice analysis](05_Subice_Analysis.ipynb) | Glacier-specific terrain segmentation and preparation for the map |
| [Field reconstruction](06_Field_Reconstruction.ipynb) | Radar registration, lagoon support, validation and field-layer exports |
| [Velocity analysis](07_Velocity.ipynb) | Selected image pairs, filters, coverage, errors and terrain alignment |
| [Integration and synthesis](08_Integration%26Synthesis.ipynb) | Retreat-zone overlays, profiles, sensitivity checks and final comparisons |
| [Interactive map](09_Interactive_Map.ipynb) | Island explorer, glacier dashboards, 3D scenes and source credits |


:::{dropdown} Environment and input access

The working environment is `KGG375_AT3`. Its processing includes Python, QGIS/PyQGIS, GDAL, GeoPandas, Shapely, rasterio, NumPy, SciPy, pandas, xarray and supporting data-access and plotting packages. Exact package versions and a usable environment export belong with the repository's reproduction record; an environment name alone is insufficient to recreate it.

Some inputs were supplied through coursework or campaign archives, and SAR preparation includes external processing. Cached velocity products, manual outline review and original field workbooks are also part of the workflow. Access to source code alone therefore does not guarantee access to every required input or reproduction of every manual decision. Original source attribution and acquisition details are consolidated on the [References and data credits](references.md) page.
:::

:::{dropdown} Numerical exports and provenance records

The following are the principal exported records behind the appendix. Paths are relative to the [project repository](https://github.com/University-of-Tasmania-GPSS/AT3_Group2_2026). They identify analysis outputs rather than promise downloads from this page.


The velocity glacier-summary export includes the year-balanced statistics. The field reconstruction metadata retains settings and source hashes; the explorer export carries its source register, layer catalogue, processing provenance and build records. These records help trace choices and inputs while keeping the distinction between source observations, derived products and display transformations.

The explorer's HTML and neighbouring assets remain together in the exported folder. The [Explorer page](explorer.md) provides the presentation route and links to the full-window map. Its date animation clips fixed modelled geometry to mapped footprints; it does not reconstruct historical surface height or ice volume. Visual exaggeration changes the display rather than the underlying reported values.

Return to [Methods](methods.md), [Results](results.md), or [Discussion](discussion.md).
:::

| Output location | Principal records |
| --- | --- |
| `Output_Data/processed/synthesis/` | `retreat_comparison.csv`, `spatial_area_changes.csv`, `transect_termini.csv`, `transect_retreat_rates.csv`, `geology_by_retreat_zone.csv` |
| `Output_Data/processed/geomorphology/` | `Heard_glacier_thickness_summary_2019_mask.csv`, `glacier_thickness_summary_metadata.json` |
| `Output_Data/processed/geomorphology/field_surveys/reconstruction/` | `Brown_radar_registration_audit.csv`, `Brown_radar_vertical_reference_check.csv`, `Brown_interpreted_bed_metrics_primary.csv`, `Brown_interpreted_bed_model_cells.csv`, `Brown_lagoon_2004_block_predictions.csv`, `Brown_lagoon_2004_support_sensitivity.csv` |
| `Output_Data/processed/synthesis/` | `candidate_bed_highs.csv`, `geomorphology_profiles.csv`, `glacier_cross_sections.csv`, `surface_exposure.csv` |
| `Output_Data/processed/synthesis/` | `Brown_supported_basin_depth_areas.csv`, `Brown_basin_historical_overlap.csv`, `Brown_lagoon_long_profile.csv`, `Brown_lagoon_cross_sections.csv`, `shoreline_gps_height_context.csv`, `Brown_radar_transect_context.csv` |
| `Output_Data/processed/velocity/` | `Heard_glacier_velocity_summary.csv`, `Heard_velocity_elevation_bands.csv`, `Heard_velocity_selected_pairs.csv`, `Heard_focus_lower_third_filter_audit.csv`, `Heard_velocity_threshold_sensitivity.csv`, `Heard_velocity_error_summary.csv` |
| `Output_Data/processed/synthesis/` | `focus_evidence_summary.csv`, `synthesis_metadata.json`, `geomorphology_analysis_metadata.json` |


(appendix-figures)=
## I. List of figures

:::{dropdown} Index

- [](#fig-opening-photo) — Opening photograph of calving glacier
- [](#fig-study-area) — Heard Island study-area locator
:::

:::{dropdown} Methods

- [](#fig-methods-workflow) — Analysis workflow
- [](#fig-methods-sar) — SAR boundary evidence
- [](#fig-field-crevasse) — Crevasse field photograph
- [](#fig-methods-terrain) — Modelled ice thickness and bed elevation
- [](#fig-methods-transects) — Analysis routes and field coverage
- [](#fig-field-elevated-science) — "Elevated Science" field photograph
- [](#fig-methods-lagoon-qa) — Brown Lagoon reconstruction and validation checks
- [](#fig-field-moss-rock) — "MossRock" field photograph
- [](#fig-methods-geology) — Mapped geological categories
- [](#fig-methods-surface-terrain) — Surface hillshade, slope and aspect
- [](#fig-methods-velocity) — Filtered ice-velocity maps
:::

:::{dropdown} Results

- [](#fig-results-retreat) — Retreat timing and mapped area change
- [](#fig-results-low-elevation) — Low-elevation glacier footprints
- [](#fig-results-geology) — Geology across retreat zones
- [](#fig-results-geometry) — Glacier geometry and flow profiles
- [](#fig-results-exposure) — Geometric summer exposure
- [](#fig-results-lagoon) — Brown Lagoon supported basin geometry
- [](#fig-field-brown-lagoon-heli) — Brown Lagoon helicopter photograph
- [](#fig-results-lagoon-bed) — Lagoon depths and modelled glacier terrain
:::

:::{dropdown} Discussion

- [](#fig-discussion-synthesis) — Synthesis of retreat histories and terrain
- [](#fig-field-stephenson-heli) — Stephenson Glacier helicopter photograph
- [](#fig-field-survey-dude) — Field surveying photograph
:::

:::{dropdown} Conclusion

- [](#fig-field-dougie-snowshoeing) — "Dougie snowshoeing" photograph - no, we don't know who Dougie is either, but he looks stoked to be there.
:::

:::{dropdown} Appendix

- [](#fig-appendix-bed-highs) — Screened modelled bed highs
- [](#fig-appendix-cross-sections) — Glacier cross-sections and lateral support
:::
