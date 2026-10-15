# The shape of retreat. 
KGG375 AT3 Group 2 University of Tasmania 2026 <br>
Brown and Stephenson glaciers, Heard Island.<br>
Two neighbouring glaciers.Two different retreat histories. <br>
Griffin and Sampson 2026
<!-- PROJECT LOGO -->
<br />
<div align="left">
  <a href="https://university-of-tasmania-gpss.github.io/AT3_Group2_2026/">
    <img src="Input_Data/2003-04_CampaignData/scotty%20digital%20pics/Stephesnons%20from%20Heli%2004.jpg" alt="Stephenson Glacier from helicopter, 2003-04 Heard Island campaign" width="500">
  </a>
  <br />
  <sub>Photo: Stephenson Glacier form the 2003-04 Heard Island campaign archive (Allison &amp; Thost, 2010)</sub>


# Research question and background

How do the mapped retreat histories of Brown and Stephenson glaciers differ, and what can glacier geometry, mapped geology, flow and archived field evidence tell us about that contrast?

Brown and Stephenson glaciers have both retreated, but their fronts have moved inland at very different rates (Tielidze et al., 2025). This project brings together historical mapping, satellite observations, terrain models and archived field surveys to examine that contrast.

Jupyter Book: The shape of retreat book is accessible via <br>
[![Read the book](https://img.shields.io/badge/_Read_the_Book-The_Shape_of_Retreat-1f6feb?style=for-the-badge)](https://university-of-tasmania-gpss.github.io/AT3_Group2_2026/)

Analysis was broken up into smaller blocks of ipynb files, with python code and markdown text within. These notebooks were merged together in the final project creation. 
## Project structure

```text
AT3_Group2_2026/
├── 01_Data_Preparation.ipynb       # Load, clip and reproject inputs
├── 02_Glacier_Retreat.ipynb        # Area loss and front retreat, 1947-2026
├── 03_Geology_Analysis.ipynb       # Mapped geological units
├── 04_Geomorphology.ipynb          # Lower-glacier geometry and terrain
├── 05_Subice_Analysis.ipynb        # Modelled ice thickness and bed
├── 06_Field_Reconstruction.ipynb   # Brown radar sections and lagoon soundings
├── 07_Velocity.ipynb               # Ice velocity (2016-2022)
├── 08_Integration&Synthesis.ipynb  # Comparative interpretation
├── 09_Interactive_Map.ipynb        # Explorer map and 3D views
├── 10_Book_Figures.ipynb           # Final book figures
├── index.md, methods.md, 
    results.md, discussion.md,
    conclusion.md, explorer.md, 
    appendix.md, references.md   
                                    # Book pages
├── myst.yml                        # Jupyter Book (MyST) configuration
├── Input_Data/                     # Source data: outlines, DEMs, geology, field archives
├── Output_Data/                    # Processed layers and intermediate outputs
├── Figures/                        # Exported figures used in the book
├── heard_island_dem/               # Derived slope, aspect and hillshade
├── heard_island_geology/           # Geology data
├── brand/, design-assets/, 
    plugins/, book-style.css        # Book styling and extensions
└── README.md
```

Ai was used in the creation of this project. Both Open Ai's Chat GPT and Claudes Sonnet was used for developing and debugging code, and pulling together work. All Ai was modified by the authors prior to use, specific requests were made to the models and finally all work was understood by the authors. 

Reproducable code blocks were taken and modified from past projects at UTAS. 