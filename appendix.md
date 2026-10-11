(appendix)=
# Supporting evidence and reproducibility

[Write: Explain that this page contains the tables, validation and supplementary figures needed to trace the principal findings. Give each table a short interpretation, units, a sampling definition and, once staged, a downloadable CSV.]

% AUTHORING: The snapshot contains notebooks and figures, but not the analysis-output CSVs. Filenames below are verified export targets from the notebook code, not working download links. Add a link only after copying the relevant export into a served book asset folder and testing it.

(appendix-inventory)=
## A. Inventory matching and retreat measurements

### Mapping scope and imposed constraints

[Write: Summarise accepted glacier identities, unmatched historical features, focus glaciers, upper-elevation retention and the no-advance constraint. Explain how these choices affect the interpretation of recent area and front changes.]

**Table placeholder:** Inventory dates, provenance, glacier identity, area, boundary constraints and coverage.

**Table placeholder:** Brown/Stephenson interval area loss and along-transect front displacement, with interval length, units and percentage denominator.

**Exports to stage:** `Output_Data/processed/synthesis/retreat_comparison.csv`, `spatial_area_changes.csv`, `transect_termini.csv` and `transect_retreat_rates.csv` from the same synthesis directory.

[Write: Add the matching and outline-audit exports from notebooks 01/02 where they materially qualify the main results.]

(appendix-geology)=
## B. Geological preparation and retreat-zone overlays

### Source-map preparation and category coverage

[Write: Document James's geometry repair, projected area calculation, coastline clipping and original category handling. Include the full area table from notebook 03, stating its denominator and any overlap/coverage qualifications.]

**Table placeholder:** Mapped `Rock_Type`, clipped mapped area in km², share of total mapped polygon area, and any explanatory category notes. Preserve original source labels in the downloadable table; explain cleaned display labels separately.

### Geological categories in the retreat zones

**Table placeholder:** Glacier, interval/zone, mapped category, intersected area, denominator, share and unmapped/Snow–Ice fractions.

**Export to stage:** `Output_Data/processed/synthesis/geology_by_retreat_zone.csv`.

[Write: Explain why the mapped categories do not establish the buried bed material or its erodibility.]

(appendix-terrain)=
## C. Surface terrain, modelled thickness and bed uncertainty

### Surface derivatives and modelled-bed derivatives

[Write: Record James's surface derivative settings, GDAL options, source resolution, CRS, slope units, aspect convention, flat-cell handling and hillshade lighting. List modelled-bed derivative settings separately.]

**Code placeholder:** The short geology or GDAL excerpt not selected for the main Methods page, with an explanation of each important operation.

### Modelled terrain and independent checks

**Table placeholder:** Grid alignment, thickness/bed masks, retained coverage, error coverage and flagged anomalies for each focus glacier.

**Table placeholder:** Eligible archived radar sections, registration confidence, model-cell count, residual definition and comparison metrics. Explain BG35's exclusion from primary metrics.

**Exports to stage:** `Output_Data/processed/geomorphology/Heard_glacier_thickness_summary_2019_mask.csv` and the interpreted-bed comparison exports named in notebook 06.

(appendix-bed-highs)=
### Screened bed highs and their persistence

:::{figure} Figures/09_Synthesis/04c_candidate_bed_highs.png
:label: fig-appendix-bed-highs
:alt: Candidate modelled bed highs along Brown and Stephenson routes with smoothing, lateral-offset and thickness-error sensitivity information.
:width: 100%
:align: center

[Caption placeholder: Adapt the final notebook 08 caption. Define screening criteria, perturbations, valid trials and persistence counts. These are candidate features, not confirmed pinning points or probabilities.]
:::

**Export to stage:** `Output_Data/processed/synthesis/candidate_bed_highs.csv`.

(appendix-cross-sections)=
### Cross-sections near fronts and candidate highs

:::{figure} Figures/09_Synthesis/04d_glacier_cross_sections.png
:label: fig-appendix-cross-sections
:alt: Brown and Stephenson cross-sections comparing surface and modelled bed profiles with explicit missing-data segments.
:width: 100%
:align: center

[Caption placeholder: Identify section positions, horizontal/vertical units, thickness error, data support and the distinction between mapped glacier width and a measured rock valley.]
:::

**Exports to stage:** `Output_Data/processed/synthesis/geomorphology_profiles.csv` and `glacier_cross_sections.csv`.

(appendix-field)=
## D. Lagoon soundings, interpolation and vertical references

### Survey support and validation

**Table placeholder:** Observed soundings by lagoon, accepted spatial support, block-validation prediction count, unsupported held-out points, residual sign, MAE/RMSE and support-rule sensitivity.

[Write: Explain which held-out points could be predicted under the support rules, and why an error statistic for those points does not describe unsurveyed lagoon areas.]

### Supported basin measurements

**Table placeholder:** Supported depth-area classes and overlap with historical glacier footprints.

**Exports to stage:** `Output_Data/processed/synthesis/Brown_supported_basin_depth_areas.csv`, `Brown_basin_historical_overlap.csv`, `Brown_lagoon_long_profile.csv` and `Brown_lagoon_cross_sections.csv` from the same directory.

### Water level, shoreline heights and the missing connection

**Table placeholder:** Recorded GPS height reference, approximate conversion, assumed lagoon water levels, scenario results and unresolved terrain gaps.

**Exports to stage:** `Output_Data/processed/synthesis/shoreline_gps_height_context.csv`, `shoreline_gps_height_summary.csv` and `Brown_radar_transect_context.csv` from the same directory.

[Write: Preserve survey-relative depth as the observed quantity. Explain why illustrative water levels are not measured bounds on lagoon elevation or hydraulic connectivity.]

(appendix-velocity)=
## E. Velocity coverage and filtering sensitivity

**Table placeholder:** Whole-glacier and lower-elevation-band speed statistics, eligible pixel counts, retained counts, coverage and supplied error context.

**Table placeholder:** Lower-band pixels lost at each filter, alternative thresholds and sensitivity to unequal annual sampling.

**Exports to stage:** `Output_Data/processed/velocity/Heard_focus_lower_third_filter_audit.csv`, `Heard_velocity_threshold_sensitivity.csv` and `Heard_velocity_error_summary.csv` from the same directory. Add the annual-sampling export identified in notebook 07.

[Write: Explain what the retained velocity population represents and why missing cells cannot be assigned zero speed.]

(appendix-exposure)=
## F. Surface-exposure geometry

**Table placeholder:** Season, hourly sampling, DEM support, footprint/elevation masks, normalisation, index statistics and valid-cell coverage.

**Export to stage:** `Output_Data/processed/synthesis/surface_exposure.csv`.

[Write: List the omitted atmospheric, cloud, albedo and shading processes and the consequences for interpreting the index.]

(appendix-evidence)=
## G. Evidence, limitations and possible alternatives

| Evidence stream | Limitation | Response in this workflow | Effect on the conclusion | Alternative or next observation |
| --- | --- | --- | --- | --- |
| Glacier inventories | [Write] | [Write] | [Write] | [Write] |
| Geological map | [Write] | [Write] | [Write] | [Write] |
| Surface terrain | [Write] | [Write] | [Write] | [Write] |
| Modelled bed | [Write] | [Write] | [Write] | [Write] |
| Field/radar registration | [Write] | [Write] | [Write] | [Write] |
| Lagoon interpolation/datum | [Write] | [Write] | [Write] | [Write] |
| Velocity support | [Write] | [Write] | [Write] | [Write] |
| Exposure index | [Write] | [Write] | [Write] | [Write] |

**Final comparison table placeholder:** Link each research objective to the accepted observation, qualification, proposed mechanism and measurement needed to test it.

**Export to stage:** `Output_Data/processed/synthesis/focus_evidence_summary.csv`.

(appendix-code)=
## H. Analysis code and reproduction

[Write: Give a brief environment, input-provenance and run-order summary. Identify external downloads, authenticated services and lecturer/archive inputs that are not distributed in the repository. Do not claim that notebook links alone make the source data reproducible.]

| Notebook | Role |
| --- | --- |
| [01 — Data preparation](01_Data_Preparation.ipynb) | Historical inputs and recent SAR outline preparation |
| [02 — Glacier retreat](02_Glacier_Retreat.ipynb) | Area histories and interval change |
| [03 — Geology analysis](03_Geology_Analysis_working.ipynb) | James's geological clipping, mapping and unit coverage |
| [04 — Geomorphology](04_Geomorphology.ipynb) | James's surface terrain derivatives, aligned thickness and modelled-bed preparation |
| [05 — Sub-ice analysis](05_Subice_Analysis.ipynb) | Segmentation and preparation of terrain context |
| [06 — Field reconstruction](06_Field_Reconstruction.ipynb) | Registered radar evidence and supported lagoon reconstruction |
| [07 — Velocity](07_Velocity.ipynb) | Flow estimates, filters, coverage and sensitivity |
| [08 — Integration and synthesis](08_Integration%26Synthesis.ipynb) | Integrated comparisons and finished results figures |
| [09 — Interactive map](09_Interactive_Map.ipynb) | Browser explorer, glacier dashboards and 3D views |

% AUTHORING: Notebook 04 contains contributions from both authors; finalise detailed ownership in README/meeting summaries rather than assigning its entire content to one contributor. Notebook 08's ampersand is URL-encoded only in this Markdown link.

See the repository [README](README.md) for contributor details, AI use, environment requirements and the published book link.
