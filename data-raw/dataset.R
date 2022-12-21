
library("magrittr")

source("./R/find_peaks.R")
source("./R/download_source_files.R")

# Connect to remote devices using SSH connection; save source files to 
# local project.

download_source_files(host_name = "pi@10.0.0.43", 
                      device_name = "pi", 
                      user_name = "pi@10.0.0.43", 
                      source_path = "/home/pi/Desktop/bme280/data", 
                      destination_path = "./inst/extdata")

download_source_files(host_name = "pi@10.0.0.220", 
                      device_name = "PI2", 
                      user_name = "pi@10.0.0.220", 
                      source_path = "/home/pi/Desktop/bme280/data", 
                      destination_path = "./inst/extdata")

download_source_files(host_name = "pi3@10.0.0.155",
                      device_name = "pi3@10.0.0.155",
                      user_name = "raspberryPI3",
                      source_path = "/home/pi3/Desktop/bme280/data",
                      destination_path = "./inst/extdata")

# Read source data and combine into single dataset; add device name to dataset.

files <- list.files("./inst/extdata/data", full.names = TRUE)

readings <- data.frame()

for(f in 1:length(files)) {
    
        source <- read.csv(files[f],
                           header = FALSE,
                           sep = ",",
                           stringsAsFactors = FALSE,
                           na.strings = c(""),
                           skipNul = TRUE)

        source <- cbind(source, f)
                
        readings <- rbind(readings, source)
    
}

# Clean and transform source data.

readings <- readings %>%
        dplyr::select(-V6) %>%
        dplyr::rename(reading_id = V1,
                      date = V2,
                      degrees_celcius = V3,
                      barometric_pressure = V4,
                      relative_humidity = V5,
                      device_id = f) %>%
        dplyr::mutate(degrees_fahrenheit = round(degrees_celcius * 9 / 5 + 32, 2),
                      degrees_celcius = round(degrees_celcius, 2),
                      barometric_pressure = round(barometric_pressure, 2),
                      relative_humidity = round(relative_humidity, 2),
                      date_time = lubridate::ymd_hms(date,
                                         quiet = FALSE,
                                         tz = "America/New_York",
                                         locale = Sys.getlocale("LC_TIME"),
                                         truncated = 0)) %>%
        dplyr::arrange(date_time) %>%
        dplyr::mutate(state = dplyr::case_when(date_time > "2021-07-27 10:00:00" & date_time < "2021-07-30 11:30:01" ~ "N",
                                               date_time > "2021-07-30 11:30:00" & date_time < "2021-08-01 18:15:01" ~ "D",
                                               date_time > "2021-08-01 18:15:00" & date_time < "2021-09-02 09:00:00" ~ "I",
                                               date_time > "2021-09-02 09:00:00" ~ "N"),
                      room = dplyr::case_when(date_time > "2021-07-27 10:00:00" & date_time < "2021-09-24 22:28:02" ~ "UB",
                                              date_time > "2022-03-12 18:05:00" ~ "UH"),
                      peak_rh = ifelse(dplyr::row_number() %in% find_peaks(relative_humidity, m = 30), TRUE, FALSE),
                      interval = round(as.numeric(date_time - lag(date_time), units = 'mins'), 5),
                      month_of_year = lubridate::month(date_time),
                      day_of_week = lubridate::wday(date_time, label = FALSE),
                      hour_of_day = lubridate::hour(date_time)) %>%
        dplyr::select(device_id,
                      reading_id,
                      date_time,
                      month_of_year,
                      day_of_week,
                      hour_of_day,
                      interval,
                      degrees_celcius,
                      degrees_fahrenheit,
                      barometric_pressure,
                      relative_humidity,
                      state,
                      room,
                      peak_rh) %>%
        dplyr::arrange(date_time, device_id)

# Save data.

usethis::use_data(readings, overwrite = TRUE)

# Clear memory.

rm(source, f, files, download_source_files, find_peaks)
