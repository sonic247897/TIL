library("ggplot2")
library("dplyr")
nrow(mpg)
mpg %>% group_by(class) %>% 
  summarise(cty_avg = mean(cty))

mpg %>% group_by(class) %>% 
  summarise(cty_avg = mean(cty)) %>% 
  arrange(desc(cty_avg))

mpg %>% group_by(manufacturer) %>% 
  summarise(hwy_avg = mean(hwy)) %>% 
  arrange(desc(hwy_avg)) %>% 
  head(3)

mpg %>% group_by(manufacturer) %>%
  filter(class=="compact") %>% 
  summarise(compact_num = n()) %>% 
  arrange(desc(compact_num))

