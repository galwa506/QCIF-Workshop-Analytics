# ---- LOAD PACKAGES ----
source("00_load_packages.R")

# ---- READ AND CLEAN FILES ----
read_and_clean <- function(file) {
  data <- readr::read_csv(file)
  
  if(!"Mobile" %in% names(data)) data$Mobile <- NA
  if ("Buyer.mobile" %in% names(data)) data$Buyer.mobile <- as.character(data$Buyer.mobile)
  data$Mobile <- as.character(data$Mobile)
  
  if ("Event" %in% names(data)) {
    data <- data %>%
      mutate(
        # Clean workshop name: remove all parentheses
        workshop = str_trim(str_remove_all(Event, "\\([^()]*\\)")),
        
        # Extract month only
        month = str_extract(
          Event,
          regex("\\((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Sept|Oct|Nov|Dec)", ignore_case = TRUE)
        ) %>%
          str_remove("\\(") %>%
          stringr::str_to_title()
      )
  }
  
  return(data)
}

# Save merged outputs
output_dir <- here("output")
dir.create(output_dir, showWarnings = FALSE)

# ---- LOAD WORKSHOP DATA ----
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

# ---- AUTO-DETECT ALL YEAR FOLDERS ----
years <- list.dirs("data", full.names = FALSE, recursive = FALSE)
years <- years[str_detect(years, "^\\d{4}$")]   # keep only 2024, 2025, etc.

# ---- Load all years ----
all_years_data <- map(years, load_workshop_data) %>% 
  set_names(years)

# ---- COMBINE ATTENDANCE ACROSS ALL YEARS ----
combined_attendance <- map2_dfr(
  all_years_data,
  names(all_years_data),
  ~ .x$attendance %>% mutate(year = .y)
)

# ---- COMBINE WAITLIST ACROSS ALL YEARS ----
combined_waitlist <- map2_dfr(
  all_years_data,
  names(all_years_data),
  ~ .x$waitlist %>% mutate(year = .y)
)

# Export final merged attendance and waitlist datasets to output directory
readr::write_csv(combined_attendance, file.path(output_dir, "attendance_all_years.csv"))
readr::write_csv(combined_waitlist, file.path(output_dir, "waitlist_all_years.csv"))

