# ---------------------------------------------------------
# 00_load_packages.R
# Packages used in QCIF workshop analytics
# ---------------------------------------------------------

library(tidyverse)   # core data wrangling + ggplot
library(openxlsx)    # excel files
library(here)        # project file paths
library(anytime)     # flexible date parsing
library(lubridate)   # dates + times
library(janitor)     # cleaning helpers
library(digest)      # hashing IDs
library(scales)      # labels + scales for plots

message("Packages loaded.")
