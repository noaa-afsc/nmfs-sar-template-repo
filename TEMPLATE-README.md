# !This is a Template Repository - Edit Content Below for Your Species

## Common Name (_Genus species_)

This repository supports the development, co-authoring, and version tracking for the !Insert Common Name! marine mammal stock assessment report(s) authored at the NOAA Fisheries Alaska Fisheries Science Center's Marine Mammal Laboratory.

## Repository Structure

This repository is organized into directories that each represent a single stock assessment report for the species. In some cases, there will be only a single stock and, in other cases, there might be multiple stocks/directories.

Keep shared project settings and website navigation in `_quarto.yml`, and stock-specific report metadata in each report's `.qmd` file. Shared R functions, supporting data, and resources such as styles, references, and fonts belong in `R/`, `data/`, and `assets/`, respectively. Add or remove stock directories as needed; this layout is a starting point, not a requirement to keep every stock identical.

### Species Stock A

insert brief description of this stock
  
### Species Stock B

insert brief description of this stock

## Rendering the reports

Install Quarto 1.11.9 and the R packages required by the reports, then run `quarto render` from the repository root to render the configured HTML and Typst PDF outputs. The publish workflow uses the same Quarto version and renders the project.

## Contact Information

The primary author(s) responsible for maintaining this repository are:

  1. Author Name [](author.name@noaa.gov)
  2. Author Name [](author.name@noaa.gov)
  
## Published (Official) Versions

   Official versions of all marine mammal stock assessement reports by region are found at: [https://www.fisheries.noaa.gov/national/marine-mammal-protection/marine-mammal-stock-assessment-reports-region](https://www.fisheries.noaa.gov/national/marine-mammal-protection/marine-mammal-stock-assessment-reports-region).
  
The information and documents provided within this repository are not the official published stock assessment reports. This repository is (currently) only available internal to NMFS and is done so within the spirit of improved transparency, reproducibility, and the main principles of open science.

## Disclaimer

“The United States Department of Commerce (DOC) GitHub project code is provided on an ‘as is’ basis and the user assumes responsibility for its use. DOC has relinquished control of the information and no longer has responsibility to protect the integrity, confidentiality, or availability of the information. Any claims against the Department of Commerce stemming from the use of its GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.”

![NOAA Fisheries](https://raw.githubusercontent.com/nmfs-general-modeling-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png)

[U.S. Department of Commerce](https://www.commerce.gov/) | [National Oceanographic and Atmospheric Administration](https://www.noaa.gov) | [NOAA Fisheries](https://www.fisheries.noaa.gov/)
