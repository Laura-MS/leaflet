# Creating leaflet map for tissue sample locations
# Created by Laura Smith
# Date created: 2022-05-25
# Date updated: 2022-05-30
# recreating leaflet map that I made in QGIS in R

# Resources used: 
# https://www.listendata.com/2020/12/leaflet-in-R.html
# https://rstudio.github.io/leaflet/markers.html 
# https://rstudio.github.io/leaflet/popups.html
# https://github.com/rstudio/leaflet/blob/main/inst/examples/labels.R
# https://stackoverflow.com/questions/46045466/leaflet-addcirclemarkers-radius-on-r

# setup
setwd("~/Sailfish PhD/Tissue sampling/Tissue sampling locations/Map/leaflet")
library(leaflet)
library(tidyverse)
dat <- read_csv("2022-05-25_sailfish_samples.csv")
dat <- dat %>% rename(Location = `Location name`)
dat$radius <- findInterval(dat$Samples,c(10,20,30,35,53))
dat$radius <- (dat$radius + 1) *3


m <- leaflet(dat) %>%
  addTiles(urlTemplate = 'http://services.arcgisonline.com/ArcGIS/rest/services/Canvas/World_Dark_Gray_Base/MapServer/tile/{z}/{y}/{x}') %>%
  addCircleMarkers(~Longitude, ~Latitude,
                   radius = ~radius,
                   color = "#232323",
                   fillOpacity = 1,
                   fillColor = "#9568e7", 
                  popup = ~paste(               
                  paste('<b>', 'Location name:', '</b>', Location),                
                  paste('<b>',  'Country:', '</b>', Country),               
                  paste('<b>', 'Ocean:', '</b>', Ocean),               
                  paste('<b>', 'Samples:', '</b>', Samples),
                  paste('<b>', 'Status:', '</b>', Status),
                  sep = '<br/>'),
                  popupOptions = popupOptions(closeButton = FALSE),
                  label = ~Location,
                  labelOptions = labelOptions(noHide = T, color = "#ffffff", textsize = "10px", 
                                              offset = c(0, -16), textOnly = TRUE, direction = "auto",
                                              style = 
                                                list("color" = "white", "font-family" = "sans-serif", "font-style" = "arial"))) %>%
  addMeasure()




