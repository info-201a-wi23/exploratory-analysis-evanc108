# Code for Aggregate Table
# Emily Hao

mars_df <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/mars-weather/mars-weather.csv", stringsAsFactors = FALSE)
library("stringr")
library("dplyr")

# get rid of "month" in month column
mars_df <- mars_df %>% 
  mutate(Month = str_sub(month, start = 7))

# change Month data type from character to integer
mars_df$Month = as.numeric(as.character(mars_df$Month))

mars_df <- mars_df %>% 
  mutate(temp_diff = max_temp - min_temp, na.rm = TRUE)

mars_min_temp <- mars_df %>% 
  group_by(Month) %>% 
  summarize(avg_min_temp = mean(min_temp, na.rm = TRUE)) 
mars_max_temp <- mars_df %>% 
  group_by(Month) %>% 
  summarize(avg_max_temp = mean(max_temp, na.rm = TRUE))
mars_avg_pressure <- mars_df %>% 
  group_by(Month) %>% 
  summarize(avg_pressure = mean(pressure, na.rm = TRUE))
mars_avg_temp_diff <- mars_df %>% 
  group_by(Month) %>% 
  summarize(avg_temp_diff = mean(temp_diff, na.rm = TRUE))

aggregate_table <- left_join(mars_min_temp, mars_max_temp, by = "Month")
aggregate_table1 <- left_join(mars_avg_temp_diff, mars_avg_pressure, by = "Month")
aggregate_table <- left_join(aggregate_table, aggregate_table1, by = "Month")
aggregate_table <- aggregate_table %>% arrange(Month)

# Round Numbers
aggregate_table <- aggregate_table %>% mutate(across(everything(), round, 1))
