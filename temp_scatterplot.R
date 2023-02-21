library(ggplot2)
library(dplyr)
library(tidyr)

mars_df <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/mars-weather/mars-weather.csv", 
                    stringsAsFactors = FALSE)

# avg temp of each day
avg_temp <- mars_df %>%
  group_by(terrestrial_date) %>%
  mutate(mean = mean(c(min_temp, max_temp), na.rm=TRUE))

year_temp <- avg_temp[avg_temp$terrestrial_date >= "2012-01-01" & avg_temp$terrestrial_date < "2018-06-01",
                          c("terrestrial_date", "mean")]

 scatterplot <- ggplot(year_temp, aes(x = as.Date(terrestrial_date), y = mean)) +
  geom_point(size = 0.5, na.rm = T) +
  labs(title = "Average Daily Temperature on Mars") +
  scale_x_date(date_breaks="6 month", date_labels="%B-%Y",) +
  xlab("Date (2012-2018)") +
  ylab("Average Temperature (°C)") +
  theme_minimal() +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5), 
        axis.text.x = element_text(angle=40, hjust = 1)) 
