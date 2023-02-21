mars_df <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/mars-weather/mars-weather.csv", stringsAsFactors = FALSE)
library("dplyr")
library("stringr")
library("tidyverse")

# get rid of "month" in month column
mars_df <- mars_df %>% 
  mutate(Month = str_sub(month, start = 7))

mars_df <- mars_df %>% 
  mutate(temp_diff = max_temp - min_temp, na.rm = TRUE)

mars_days_observed <- mars_df %>% 
  filter(sol == max(sol)) %>% 
  pull(sol)

# Find the date when the average temperature difference varied the most, and what those temperatures were

highest_temp_diff <- mars_df %>% 
  filter(temp_diff == max(temp_diff, na.rm = TRUE)) %>% 
  pull(temp_diff)

month_highest_temp_diff <- mars_df %>% 
  filter(temp_diff == max(temp_diff, na.rm = TRUE)) %>% 
  pull(Month)

lowest_temp_diff <- mars_df %>% 
  filter(temp_diff == min(temp_diff, na.rm = TRUE)) %>% 
  pull(temp_diff)

month_lowest_temp_diff <- mars_df %>% 
  filter(temp_diff == min(temp_diff, na.rm = TRUE)) %>% 
  pull(Month)

# The maximum temperature difference is 85 degrees Celsius which occurred during Month 7, while the minimum temperature difference is 45 degrees Celsius, which occurred during Month 3.

# Find the date of the highest temperature and what that temperature was

month_highest_temp <- mars_df %>% 
  filter(max_temp == max(max_temp, na.rm = TRUE)) %>% 
  filter(sol == max(sol)) %>% 
  pull(Month)

highest_temp <- mars_df %>% 
  filter(max_temp == max(max_temp, na.rm = TRUE)) %>% 
  filter(sol == max(sol)) %>% 
  pull(max_temp)

month_lowest_temp <- mars_df %>% 
  filter(min_temp == min(min_temp, na.rm = TRUE)) %>% 
  filter(sol == min(sol)) %>% 
  pull(Month)

lowest_temp <- mars_df %>% 
  filter(min_temp == min(min_temp, na.rm = TRUE)) %>% 
  filter(sol == max(sol)) %>% 
  pull(min_temp)

# The highest temperature recorded during one day was 11 degrees Celsius, which was observed during Month 7, while the lowest temperature observed is -90 degrees, which occurred during Month 3.
avg_p <- mars_df %>% 
  summarize(avg_mars_p = mean(pressure, na.rm = TRUE))

# Find the average pressure
#avg_pressure <- mars_df %>% 
 # summarize(avg_mars_pressure = mean(pressure, na.rm = TRUE)) %>% 
  #pull(pressure)

# Find the lowest and highest pressure
lowest_pressure <- mars_df %>% 
  filter(pressure == min(pressure, na.rm = TRUE)) %>% 
  pull(pressure)

month_lowest_pressure <- mars_df %>% 
  filter(pressure == min(pressure, na.rm = TRUE)) %>% 
  pull(Month)

highest_pressure <- mars_df %>% 
  filter(pressure == max(pressure, na.rm = TRUE)) %>% 
  filter(sol == max(sol)) %>% 
  pull(pressure)

month_highest_pressure <- mars_df %>% 
  filter(pressure == max(pressure, na.rm = TRUE)) %>% 
  filter(sol == max(sol)) %>% 
  pull(Month)

