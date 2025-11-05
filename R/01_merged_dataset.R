library(tidyverse)
library(openxlsx)
library(here)

# Helper function to read and clean each csv
read_and_clean <- function(file) {
  data <- readr::read_csv(file)
  
  if(!"Mobile" %in% names(data)) data$Mobile <- NA
  if ("Buyer.mobile" %in% names(data)) data$Buyer.mobile <- as.character(data$Buyer.mobile)
  data$Mobile <- as.character(data$Mobile)
  
  return(data)
}

# General helper function to load and clean data for any year
load_workshop_data <- function(year, base_dir = "data") {
  
  # Build dir path
  dir_path <- file.path(base_dir, year)
  if (!dir.exists(dir_path)) {
    stop(paste("Data folder not found:", dir_path))
  }
  
  files <- dir(dir_path, full.names = T)
  
  # Separate attendance and waitlist files
  waitlist_files <- keep(files, ~str_detect(., "waitlist"))
  attendance_files <- keep(files, ~!str_detect(., "waitlist"))
  
  
  # Read and bind rows for both attendance and waitlist
  attendance_data <- map_dfr(attendance_files, read_and_clean)
  waitlist_data   <- map_dfr(waitlist_files, read_and_clean)
  
  # ---- SAVE MERGED OUTPUTS ----
  output_dir <- here("output")
  dir.create(output_dir, showWarnings = FALSE)
  
  if (nrow(attendance_data) > 0) {
    readr::write_csv(attendance_data, file.path(output_dir, paste0("attendance_", year, ".csv")))
  }
  
  if (nrow(waitlist_data) > 0) {
    readr::write_csv(waitlist_data, file.path(output_dir, paste0("waitlist_", year, ".csv")))
  }
  
  # Return both datasets as a list
  list(
    attendance = attendance_data,
    waitlist = waitlist_data
  )
}

# ---- Load all years ----
data_2024 <- load_workshop_data("2024")
data_2025 <- load_workshop_data("2025")

# Access individual datasets
attendance_data_2024 <- data_2024$attendance
waitlist_data_2024   <- data_2024$waitlist

attendance_data_2025 <- data_2025$attendance
waitlist_data_2025   <- data_2025$waitlist

