# MML SAR Quarto Repository Template

This repository is a starting point for developing and versioning marine mammal
stock assessment reports (SARs) for the NOAA Fisheries Alaska Fisheries Science
Center's Marine Mammal Laboratory. It is configured as a Quarto website with two
example reports for the placeholder species Pakicetus: Stock A and Stock B.
Replace the example species, stock information, and report content with the
species and stocks for your project (for example, Steller sea lion, eastern and
western stocks).

## Project structure

| Path | Purpose |
| --- | --- |
| `_quarto.yml` | Quarto website settings, site navigation, and the report files included when rendering the project. |
| `pakicetus-stockA/pakicetus-stockA.qmd` | Example Stock A report, including report metadata, R setup code, and report section templates. |
| `pakicetus-stockB/pakicetus-stockB.qmd` | Example Stock B report. |
| `assets/` | Shared presentation and citation resources: NOAA Fisheries logos, fonts, `sar_theme.scss`, `apa.csl`, and the example `references_pakicetus.json`. The `add-template-files-here` file marks this directory for additional shared files. |
| `data/` | Location for supporting data. `spatial_data/` is provided for spatial data; `add-supporting-data-files-here` marks the top-level directory. |
| `R/` | Location for shared R functions sourced by the reports. `add_custom_R_functions.md` contains guidance for adding functions. |
| `scripts/` | Location for project scripts; `add_custom_scripts.md` contains guidance. |
| `DESCRIPTION` | R package metadata and declared package dependencies for this project. |
| `mml-sar-template.Rproj` | RStudio project file. |
| `.github/workflows/publish_pakicetus.yml` | GitHub Actions workflow for rendering the example project; it sets up Quarto 1.11.9 and installs R and system dependencies. |

## Customize for your species and stocks

1. **Update the report directories and files.** Rename the `pakicetus-stockA`
   and `pakicetus-stockB` directories and their `.qmd` files to identify your
   species and stocks. Add or remove report files if your species has a
   different number of stocks.
2. **Update `_quarto.yml`.** For every report, update both `project.render` and
   `website.navbar.left`. These lists determine which reports are rendered and
   which links appear in the website navigation. Update the site title and
   navigation labels as well.
3. **Edit each report's front matter and content.** Replace the title, subtitle,
   species and stock metadata, publication dates, authors, affiliations, and
   report text. The example reports include section prompts to guide completion.
   Update the bibliography path and citations for your species.
4. **Replace shared assets and data.** Update or replace the example
   `assets/references_pakicetus.json` bibliography and add project-specific
   figures, data, spatial data, or other shared resources in the appropriate
   directories.
5. **Add shared code as needed.** The reports source `.R` files in `R/` during
   setup. Put reusable functions there and project-specific scripts in
   `scripts/`.
6. **Update dependencies and publishing configuration.** Keep `DESCRIPTION`
   and the package installation list in the GitHub Actions workflow consistent
   with the packages used by your reports. If you retain the example publishing
   workflow, update its Pakicetus-specific name and configuration for your
   project.

## Prerequisites and R packages

- **Quarto:** The publishing workflow uses Quarto **1.11.9**.
- **R:** Install R and the R packages required by the report content.
- **R packages in `DESCRIPTION`:** The current `Depends` field lists `dplyr`,
  `rnaturalearth`, `rnaturalearthhires`, and `sf`. The `Remotes` field identifies
  `ropensci/rnaturalearthhires` as the source for `rnaturalearthhires`.
- **Additional packages in the example reports and workflow:** The report setup
  code also uses `ggplot2`, `purrr`, and `fs`; it sources files using `here` and
  uses `knitr` and `ragg`. The publishing workflow installs these packages and
  also lists `tibble`, `forcats`, `readr`, `tidyr`, `janitor`, `rmarkdown`,
  `ggtext`, `ggrepel`, `glue`, `gt`, `gtExtras`, `arcgis`, `rcartocolor`,
  `systemfonts`, and `patchwork`. Install the packages required by the reports
  you keep, and update the project dependency metadata and workflow when those
  requirements change.
- **System libraries:** The Ubuntu publishing workflow installs
  `libcurl4-openssl-dev`, `libudunits2-dev`, `libgdal-dev`, `libgeos-dev`,
  `libproj-dev`, `libprotobuf-dev`, `protobuf-compiler`, and `libjq-dev`. On
  other operating systems, install the corresponding system dependencies
  required by your R packages.

Add R package requirements to the `Depends` field in `DESCRIPTION`, following
the existing entries, or use the package metadata field appropriate to the
dependency. For a package hosted outside the standard repositories, `Remotes`
can identify its source; this project uses `ropensci/rnaturalearthhires`.
`DESCRIPTION` does not replace installing the packages in your local R library.
The publishing workflow installs `rnaturalearthhires` with this command:

```sh
R -e 'install.packages("rnaturalearthhires", repos = "http://ropensci.r-universe.dev", type = "source")'
```

The report files declare HTML and `nmfs-sar-pdf-typst` output formats. The
website configuration selects HTML, while the repository does not include a
definition for the custom `nmfs-sar-pdf-typst` format. Make that format
available in your Quarto environment if you need to render the PDF output.

## Render the project

### RStudio

Open `mml-sar-template.Rproj`, then open a report `.qmd` file and use its
**Render** button to render that report. To render all reports configured for
the website, run the project-level command below in the RStudio Terminal.

### Positron

Open the repository folder in Positron, then run the project-level command
below in its integrated terminal.

### Terminal

Run this command from the repository root to render the reports listed in
`_quarto.yml`:

```sh
quarto render
```

The website output directory `_site/` is excluded from version control.
