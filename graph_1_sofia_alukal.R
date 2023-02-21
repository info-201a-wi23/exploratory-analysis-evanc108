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

all_totals <- left_join(avg_temp, range_temperature, by = c("terrestrial_date" = "terrestrial_date"))

View(all_totals)
all_totals <- all_totals[all_totals$terrestrial_date >= "2017-01-01" & all_totals$terrestrial_date < "2018-01-01", c("terrestrial_date", "mean", "max_temp.x", "min_temp.x")]

## read csv earth
##ggplot(data = year_2018_temp) +
  #geom_line(aes(x = as.Date(terrestrial_date), y = avg_temp)) +
  #scale_color_brewer(palette = "Set2") +
  #labs(title = "Min vs Max Temperatures over 2019", x = "Months", y = "Temperature (C)") +
  #scale_x_continuous(breaks = seq(1, 12, 1)) +


linear_plot <- ggplot(data = all_totals) +
  geom_line(aes(x = as.Date(terrestrial_date), y = max_temp.x, color = "Max"), linewidth = 0.2) +
  geom_line(aes(x = as.Date(terrestrial_date), y = mean, color = "Average"), linewidth = 0.2) +
  geom_line(aes(x = as.Date(terrestrial_date), y = min_temp.x, color = "Min"), linewidth = 0.2) +
  geom_smooth(aes(x = as.Date(terrestrial_date), y = mean), linewidth = 0.5) + 
  labs(title = "Difference in Min and Max Temperature over a Year on Mars",
       x = "Date (months/2017)",
       y = "Average Temperature (°C)",
       color = "Temperature Groups"
       ) +
  scale_x_date(date_breaks="1 month", date_labels="%B",) +
  theme(plot.title = element_text(hjust = 0.5), 
          axis.text.x = element_text(angle=40, hjust = 1)) 
