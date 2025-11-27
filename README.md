## QCIF Workshop Analytics – Data Pipeline & Insights

This repository contains a reproducible R-based data pipeline for cleaning, standardising, and integrating multi-year Humanitix workshop attendance data. It focuses on resolving inconsistencies across raw files and producing clean, analysis-ready datasets for further internal use.

### Project Structure
```
QCIF-Workshop-Analytics/
│
├── data/ # Raw Humanitix exports (attendance, waitlist, pricing)
├── output/ # Cleaned and merged datasets (CSV / RDS)
├── R/ # Scripts used in the pipeline
│ ├── 00_load_packages.R
│ ├── 01_data_merge.R
│ ├── 02_data_cleaning.R
│ └── 03_data_analysis.R
└── README.md
```

### Requirements / Tools

This project uses:

- R (version 4+)
- tidyverse for data cleaning and wrangling
- janitor for column standardisation
- lubridate for date handling
- here for path management
- digest for hashed IDs
- readr / readxl for file ingestion

### Outputs

Cleaned datasets are stored in the output/ folder:

- attendance_all_years_cleaned.csv
- attendance_cleaned.rds
- attendance_with_prices.rds

### How to Run

Place raw Humanitix files into the data/ folder

Run the scripts in order:
- 00_load_packages.R
- 01_data_merge.R
- 02_data_cleaning.R
- 03_data_analysis.R
Outputs will generate automatically into output/

### Project Goals

- Clean and consolidate multi-year Humanitix workshop data
- Standardise workshop names, organisations, and categories
- Build a repeatable and scalable data pipeline
- Generate insights on participation, institutions, demand, revenue and trends
- Prepare the dataset for predictive attendance modelling

### Project Purpose

- Consolidate all 2024–2025 Humanitix workshop files
- Create a consistent structure across raw datasets
- Standardise workshop names, organisations, and categories
- Merge attendance, waitlist, pricing, and metadata into a unified dataset
- Produce a modelling-ready foundation for attendance forecasting

### Author

- Galey Wangmo
- Master of Data Science - James Cook University
