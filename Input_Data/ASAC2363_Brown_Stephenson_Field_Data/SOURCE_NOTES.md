# Brown and Stephenson historical field data

This is a focused subset of the public ASAC_2363 archive, downloaded on 9 October 2026. It is not the complete campaign archive. The 14 downloaded source files are unmodified. DOWNLOAD_MANIFEST.json records source URLs, byte counts and SHA-256 hashes.

## Sources and attribution

Dataset: Allison, I. & Thost, D.E. (2010). Heard Island glacier fluctuations and climatic change - 2003/04 Fieldwork, Version 1. Australian Antarctic Data Centre. https://doi.org/10.4225/15/574BBEA0D74B7

Metadata: https://data.aad.gov.au/metadata/records/ASAC_2363

Current catalogue: https://data.aad.gov.au/dataset/7319C791-3989-4AB7-8BE4-35813D84E6B1

Report: Thost, D.E., Truffer, M. & Donoghue, S. (2004). The Heard Island glaciology program 2003-04: studies on the morphology, dynamics, mass balance, and climatic setting of Brown Glacier. Data report. Australian Antarctic Division. See Report/HI_data_report_screen.pdf.

Licence: CC BY 4.0; retain attribution. The original LICENSE and README are included.

## Lagoon bathymetry

- Brown 2004 CSV: 211 soundings; deepest available sounding 56 m.
- Stephenson 2004 CSV: 16 soundings (waypoints 46-61); deepest available sounding 107 m.
- Stephenson map: survey dates 17 January and 16 February 2004. The published map shows many more soundings than the CSV, including a sounding labelled 113 m deep. Treat the currently archived Stephenson CSV as a subset of the plotted survey. A complete numerical table has not been located.
- Both source CSVs store depth as negative values relative to lagoon water surface. For positive water depth, use depth_m = -depth. Water surface is documented as approximately sea level; this does not supply an exact modern vertical datum transformation.
- Coordinates: WGS84 / UTM zone 43S (EPSG:32743); E and N are metres. WP in the Stephenson CSV is a waypoint identifier.
- Survey method: Garmin acoustic depth sounder and handheld GPS. The report gives positional accuracy within 10 m; map captions give +/-5 m. Depth checks were within 1 m for depths reachable with a 30 m tape. Deeper soundings are estimated accurate to +/-5% and were not checked with that tape.
- Retain the original JPG maps: they document coverage, survey points and interpretation. Contours are interpolated interpretations, not additional soundings.
- The earlier Brown 2000 data supplied separately by the user contain 20 weighted-line soundings, deepest 52.7 m. Differences between sampled maxima in 2000 and 2004 do not establish basin deepening.

## Recommended use in the project

1. Plot the observed lagoon soundings with historical glacier outlines and the published bathymetric maps. Interpret the occupied water basin and the timing of loss of ice-water contact. The report places Brown's land termination around 1985 and notes approximately 200 m Stephenson frontal retreat from January 2003 to the 2004 survey season, with a navigable lagoon connection to the south coast.
2. Evaluate Brown modelled thickness or estimated bed against radar observations where the datasets overlap, after checking vertical datums and processing. Describe the comparison as historical field evaluation. Check whether these same observations informed the model before describing it as independent validation.
3. The current uploaded geomorphology notebook masks lagoons out of the candidate bed raster. Bathymetric soundings therefore complement that raster; missing model values at lagoon points cannot become model residuals.
4. Do not extrapolate a whole Stephenson lagoon bathymetric surface from the 16 available soundings. Extra points recovered from the map would need explicit georeferencing and digitisation, and must remain identified as digitised map values.
5. Check total interval loss and annualised loss separately. In the saved retreat table, Brown's greatest total interval area loss is 1947-1988, but its highest annualised area-loss rate is 1988-2014; Stephenson's highest values occur in 1988-2014. Unequal interval lengths affect that comparison.

## Brown radar and GPS files included

RES/RES.xlsx contains the BG20 and BG25 profiles from the 2003-04 field season. RES/BG35_2000.xlsx supplies an additional tabulation of the 2000 profile. Surveys contains kinematic GPS workbooks for both field seasons and a survey-point CSV.

The historical GPS method converted WGS84 ellipsoid heights to approximate sea-level elevations by subtracting 40 m. Check the individual column definitions before conversion; some radar files already contain converted elevations. Do not subtract 40 m twice.

In the user's separate 2000 Brown archive, the *bottom.dat files store along-profile distance and interpreted bed elevation, rather than geographic easting/northing. The old BG35 processing also includes zero receiver coordinates for margin placeholders in its profile fit, so naive conversion of that profile to geographic points is unreliable. The newer BG35 workbook uses explicit midpoint coordinates and a depth/bed proxy, with a different radar calculation; it should not be conflated with the manually interpreted ellipse-envelope bed.

No notebooks were modified and no raster model comparison has been run as part of preparing this source bundle.
