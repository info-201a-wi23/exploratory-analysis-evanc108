#  p2 boxplots
# sara duan

# load library
library("dplyr")

# load csv
mars_df <- read.csv("https://raw.githubusercontent.com/the-pudding/data/master/mars-weather/mars-weather.csv", stringsAsFactors = FALSE)
names(mars_df)
sum(pressure)
max(mars_df$ls, na.rm = TRUE)


ls_range_df <- mars_df %>% 
  group_by(ranges = cut(ls, breaks = seq(0, 360, by = 90)) ) %>% 
  arrange(as.numeric(ranges))
ls_range_df


boxplot <- boxplot(pressure~ranges, data = ls_range_df, 
        main = "Atmospheric Pressure in Mars for Each Season", 
        at = c(1, 2, 3, 4),
        names = c("Autumn", "Winter", "Spring", "Summer"), 
        xlab = "Season on Mars", ylab = "Atmospheric Pressure", col = "lightpink")
