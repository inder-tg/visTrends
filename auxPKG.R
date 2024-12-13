# -----------------------------------------------------------------------------
#
# Elaborado por Inder Tecuapetla, May 31, 2023
#
# Modificado Julio 28, 2023
#
# Instalación de paquetes/bibliotecas a utilizar en este módulo
# 
# Hecho para SELPER/CEOS Working Group Chapter D Training Group  
#
# -----------------------------------------------------------------------------

neededPackages <- c("shiny", "shinydashboard", "mapview", "leaflet",
                    "leafem", "htmltools", "sf", "gtools",
                    "gtools", "shinycssloaders", "shinyjs",
                    "shinyBS", "ggplot2", "dplyr", "terra",
                    "shinyWidgets", "fontawesome", "leaflet.extras",
                    "stars")

packagesToInstall <- neededPackages[!(neededPackages %in% installed.packages()[,"Package"])]

if( length(packagesToInstall) ){
  for( i in 1:length(packagesToInstall) ){
    message("Installing package", packagesToInstall[i], "\n")
    install.packages(packagesToInstall[i], dependencies = TRUE)
  }
} 


library(shiny)
library(shinydashboard)
library(mapview)
library(leaflet)
library(leafem)
# library(RColorBrewer)
library(htmltools)
# library(tidyverse)
library(sf)

# ---

library(shinycssloaders) # Adds spinner icon to loading outputs.
library(dplyr) # Used to filter data for plots.
# library(raster)
# library(leafem)
library(rintrojs)
library(shinyjs)
library(shinyBS)
library(ggplot2)
library(shinyWidgets)
library(fontawesome)

# ---

library(leaflet.extras)
library(stars)
library(gtools)
# library(terra)
# library(bfast)
# library(imputeTS)

