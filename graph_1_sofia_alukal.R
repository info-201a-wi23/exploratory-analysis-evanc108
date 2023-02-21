## read csv mars
mars_df <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/mars-weather/mars-weather.csv", stringsAsFactors = FALSE)
library(dplyr)
library(ggplot2)
library(scales)
View(mars_df)

avg_temp <- mars_df %>% 
  group_by(terrestrial_date) %>%
  mutate(mean = mean (c(min_temp, max_temp), na.rm = TRUE))

range_temperature <- mars_df %>% 
  group_by(terrestrial_date) %>%
  select(terrestrial_date, min_temp, max_temp)

all_totals <- left_join(avg_temp, range_temperature, by = c("terrestrial_date" = "terrestrial_date"), na.rm = TRUE)

View(all_totals)
all_totals <- all_totals[all_totals$terrestrial_date >= "2017-01-01" & all_totals$terrestrial_date < "2018-01-01", c("terrestrial_date", "mean", "max_temp.x", "min_temp.x")]

## read csv earth
ggplot(data = year_2018_temp) +
  geom_line(aes(x = as.Date(terrestrial_date), y = avg_temp)) +
  scale_color_brewer(palette = "Set2") +
  labs(title = "Min vs Max Temperatures over 2019", x = "Months", y = "Temperature (C)") +
  scale_x_continuous(breaks = seq(1, 12, 1)) +
  scale_y_continuous(limits = range(year_2018_temp$max_temp.x))

