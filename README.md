![R version](https://img.shields.io/badge/R-%3E%3D4.3-lightgrey)
![Status](https://img.shields.io/badge/Project-Active-lightgrey)
![Last Commit](https://img.shields.io/github/last-commit/galwa506/QCIF-Workshop-Analytics?color=lightgrey)

## QCIF Workshop Analytics (2024–2025)

A data-cleaning and analytics pipeline for QCIF workshop datasets (2024–2025), built to automate ingestion, cleaning, integration, and preparation for reporting and future modelling.

### Key Features

- Automated ingestion of multiple workshop files across 2024–2025
- Standardised cleaning of inconsistent fields
- Normalisation of workshop names, organisations, and date formats
- Hashed IDs for participant privacy using SHA-256
- Integration of workshop pricing and member/non-member logic
- Summary-ready dataset for internal QCIF reporting

Fully script-based, reproducible workflow
### Project Structure
```
QQCIF-Workshop-Analytics/
├── R/
│   ├── 00_load_packages.R         # Loads required packages
│   ├── 01_merged_dataset.R        # Automatically detects, loads, and merges raw data
│   ├── 02_data_cleaning.qmd       # Cleaning and standardisation workflow
│   ├── 03_data_analysis.qmd       # Summary tables and exploratory analysis (no outputs saved)
│
├── data/
│   ├── 2024/                      # Raw attendance/waitlist datasets 2024 (ignored)
│   ├── 2025/                      # Raw attendance/waitlist datasets 2025 (ignored)
    ├── 2025_workshop_price.csv/   Pricing lookup data (ignored)
│
├── output/
│   ├── cleaned/                   # Final cleaned datasets (ignored)
│   ├── merged/                    # Intermediate merged files (ignored)

├── .gitignore                     # Excludes HTML, PNG, knit folders, raw data
├── renv.lock                      # Ensures reproducible R environment
├── QCIF-Workshop-Analytics.Rproj  # RStudio project file
└── README.md
```
Note: All raw datasets, images, and knitted outputs are intentionally excluded to protect QCIF internal data.


### Getting Started

#### 1. Install dependencies
source("R/00_load_packages.R")

#### 2. Merge datasets
source("R/01_merged_dataset.R")
This step automatically scans the raw folders and merges all attendance and waitlist files across years.

#### 3. Clean the data
quarto::render("R/02_data_cleaning.qmd", execute = TRUE)

#### 4. Run analysis (summary only)
quarto::render("R/03_data_analysis.qmd", execute = TRUE)

### Privacy & Data Notes
- QCIF workshop data contains private institutional information.
- Raw files, knitted reports, and generated visuals are excluded from this repository using .gitignore.
- Only scripts and reproducible workflows are included.
- This project should not be used with external datasets without QCIF approval.

### Dependencies
- R (≥ 4.3)
- tidyverse
- janitor
- here
- anytime
- lubridate
- digest
- ggplot2
- openxlsx
- quarto

### Environment Setup with renv

This project uses renv for reproducible package management. All package versions used in this workflow are locked in renv.lock.

#### 1. Install renv
install.packages("renv")

#### 2. Restore the environment
renv::restore()

This installs all packages recorded in the lockfile.

#### 3. Activate the environment
QCIF-Workshop-Analytics.Rproj

### Author
Galey Wangmo
Data Science Intern - QCIF
