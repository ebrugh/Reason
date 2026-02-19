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
  as_tibble() %>% dplyr::select(-geometry) %>%
    group_by(STATEFP10) %>%
    summarise(stateLandArea = sum(ALAND10))}


