library(tidyverse)
library(ggplot2)
library(sf)

p.counties <- "C:/R/Data/CBW/County_Boundaries.shp"
p.stations <- "C:/R/Data/CBW/Non-Tidal_Water_Quality_Monitoring_Stations_in_the_Chesapeake_Bay.shp"

d.counties <- sf::read_sf(p.counties)
d.stations <- sf::read_sf(p.stations)

library(dplyr)

glimpse(d.counties)

glimpse(d.stations)

d.stations %>% sf::st_is_valid() 

d.counties %>% dplyr::select(GEOID10, ALAND10) %>% head() 

d.counties %>% dplyr::select(-NAME10) %>% head() 

d.counties %>% dplyr::select(GEOID10:CLASSFP10) %>% head() 

d.counties %>% dplyr::select(-(GEOID10:CLASSFP10)) %>% head()

d.counties %>% dplyr::select(starts_with("C"))

d.counties %>% group_by(STATEFP10) %>% mutate(stateLandArea = sum(ALAND10))

d.counties %>% {
  as_tibble(d.counties) %>% dplyr::select(-geometry) %>%
    group_by(STATEFP10) %>%
    summarise(stateLandArea = sum(ALAND10))}

d.counties %>% {
  ggplot(., aes(x = as.factor(STATEFP10), y = ALAND10)) +
    geom_boxplot(aes(fill = STATEFP10))}

d.counties %>% {
  ggplot(., aes(x = ALAND10)) +
    geom_histogram(aes(fill = STATEFP10)) +
    labs(title = "not useful")}

d.counties %>% sf::st_crs()

d.stations %>% sf::st_crs()

d.counties %>% sf::st_crs() == d.stations %>% sf::st_crs()

del.counties <- d.counties %>% dplyr::filter(STATEFP10 == 10)

del.stations <- sf::st_intersection(d.stations, del.counties)

glimpse(del.stations)

plot(del.stations)

del.counties %>% st_area()





#Task 1 
task1_1 <- d.counties %>% {
  as_tibble(d.counties) %>% dplyr::select(-geometry) %>%
    group_by(STATEFP10) %>%
    summarise(stateWaterArea = sum(AWATER10)) 
}









