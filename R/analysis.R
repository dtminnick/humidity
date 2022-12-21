
library("dplyr")

data(readings)

monthly_readings <- readings %>%
    group_by(month_of_year) %>%
    summarise(mean_relative_humidity = mean(relative_humidity))

hourly_readings <- readings %>%
    group_by(hour_of_day) %>%
    summarise(min_relative_humidity = min(relative_humidity),
              mean_relative_humidity = mean(relative_humidity),
              sd_relative_humidity = sd(relative_humidity),
              max_relative_humidity = max(relative_humidity))

day_readings <- readings %>%
    group_by(day_of_week) %>%
    summarise(min_relative_humidity = min(relative_humidity),
              mean_relative_humidity = mean(relative_humidity),
              sd_relative_humidity = sd(relative_humidity),
              max_relative_humidity = max(relative_humidity))
