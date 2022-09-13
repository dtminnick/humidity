
library("magrittr")

source("./R/find_peaks.R")

# Connect remotely to pi using an ssh connection.
# Keyring package used to securely obtain credentials for host login.

session <- ssh::ssh_connect(host = "pi@10.0.0.43",
                            passwd = keyring::key_get("pi", "pi@10.0.0.43"),
                            verbose = FALSE)

# Use scp protocol to download files from the host via the specified
# directories.

ssh::scp_download(session,
                  files = "/home/pi/Desktop/bme280",
                  to = "./inst/extdata",
                  verbose = TRUE)

# Disconnect from ssh connection.

ssh::ssh_disconnect(session)

# Read source data.

source <- read.csv("./inst/extdata/bme280/pi1_bme280_readings.txt",
                   header = FALSE,
                   sep = ",",
                   stringsAsFactors = FALSE,
                   na.strings = c(""),
                   skipNul = TRUE)

# Clean and transform source data.

readings <- source %>%
        dplyr::select(-V6) %>%
        dplyr::rename(reading_id = V1,
                      date = V2,
                      degrees_celcius = V3,
                      barometric_pressure = V4,
                      relative_humidity = V5) %>%
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
        dplyr::select(reading_id,
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
                      peak_rh)

# Save data.

usethis::use_data(readings, overwrite = TRUE)

