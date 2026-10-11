---
site:
  hide_outline: true
---

(explorer)=
# Explore Heard Island

**We created a simple, intuitive interface to explore Heard Island and investigate its glacial retreat.** The explorer brings our maps, geological and terrain layers, velocity estimates and archived field observations into one place. Start with the island map, then open the **Brown and Stephenson dashboards** to compare their retreat histories, inspect the glaciers in 3D or explore Brown's surveyed lagoon.

[Open the full-window explorer](/explorer/Heard_Island_explorer.html)

(explorer-map)=
:::{iframe} /explorer/Heard_Island_explorer.html
:enumerated: false
:class: col-page-right heard-explorer
:title: Interactive Heard Island glacier explorer with island map, glacier dashboards and 3D views
:width: 100%
:align: center

Heard Island: ice, terrain and change. Select a glacier to inspect its available evidence, or use the island layers for spatial context.
:::

(explorer-route)=
:::{dropdown} A short route through the evidence

### 1. Identify mapped geology

Enable **Mapped geology** in the island view and move the pointer over a mapped unit. The hover card identifies the rock or deposit category. Start with an exposed foreland unit: the map describes surface materials, and a Snow/Ice category leaves the buried substrate unresolved.

### 2. Open Brown's dashboard

Select **Brown** to open its glacier dashboard. Use **Retreat** to inspect dated outlines and the available summaries, then compare layers through **Geology**, **Geomorphology** and **Velocity**. The historical outlines show where mapped ice occurred; an interval's area loss and front movement describe different aspects of change. Stephenson's dashboard provides the corresponding comparison.

### 3. Explore the glacier in 3D

From the glacier dashboard, choose **Explore in 3D**. Rotate the scene to inspect the lower glacier and its terrain, then move between inventory dates. The glacier body uses fixed modelled thickness and derived bed geometry; the animation clips it to dated footprints. Earlier ice outside model coverage appears as an outline, rather than a reconstructed historical ice body.

Use **Reset camera** to return to the initial view. Vertical and thickness exaggeration help inspect shape; their effects are visual and do not change the underlying values reported on hover.

### 4. Inspect Brown's surveyed lagoon

Return to Brown's dashboard and choose **3D lagoon**. The coloured surface shows interpolated depths within the supported reconstruction; white points show measured soundings. Rotate the basin, then toggle **Show survey water plane** to inspect its depth relative to the 2004 water surface.

Here, **0 m is the survey water surface**, rather than sea level. The retained mesh and water plane preserve unsupported gaps. The viewer shows a surveyed portion of the basin, without establishing the complete lagoon boundary or its connection to the inland glacier bed.
:::

(explorer-reading)=
:::{dropdown} Reading the map responsibly

The layers retain different dates and spatial support. A visually aligned overlay does not make them simultaneous observations or demonstrate a causal relationship. The [Methods](methods.md) explain how the products were prepared, while the [supporting evidence](appendix.md) records coverage, uncertainty and sensitivity checks.
:::

| Display | How to read it |
| --- | --- |
| Dated outlines and retreat animation | Mapped footprints at selected dates, displayed on fixed terrain. They do not reconstruct past surface heights or thickness. |
| Surface terrain | The accepted 2002 DEM supplies the terrain context. Its elevations do not describe the current surface everywhere. |
| Modelled thickness and bed | Estimates combining different observation periods. Bed gaps remain unresolved; local highs are candidates for investigation. |
| Velocity | Filtered 2016–2022 observations within the working footprints. Missing cells do not indicate stationary ice. |
| Lagoon depth and water plane | Brown's supported 2004 reconstruction, referenced to the survey water surface. Blank areas and mesh edges do not establish shorelines. |
| Colour scales and exaggeration | Consult each legend. Saturated colours group values beyond the displayed limits; exaggeration changes appearance rather than measured values. |
| Recent outlines elsewhere on the island | Provisional spatial context. The accepted recent analysis is restricted to Brown and Stephenson. |


(explorer-credits)=
:::{dropdown} Map credits

Open **Sources & credits** in the island view, or **Sources** within a dashboard or 3D viewer, to inspect the attribution associated with the displayed evidence. Full bibliographic entries are collected on the [References and data credits](references.md) page.

The original lagoon polygons are credited to **Donoghue and Harris (2021)**, with the project updates digitised by **Griffin (2026)**. Archived soundings, radar sections and campaign observations are credited to **Allison and Thost (2010)**; their shared campaign archive is treated as one source. These credits distinguish the original observations from the preparation and visualisation undertaken here.

Return to [Results](results.md), [Discussion](discussion.md), or [Conclusion](conclusion.md).
:::
