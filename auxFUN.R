
fluid_design <- function(id, w) {
  fluidRow(
    div(
      id = id,
      column(
        width = 12,
        uiOutput(w),
        # uiOutput(y)
      ),
      # column(
      #   width = 6,
      #   uiOutput(x),
      #   # uiOutput(z)
      # )
    )
  )
}

get_timeSeries_byClicking <- function(toPlot, df){
  
  # toPlot = c(LONG, LAT); df = TEST
  
  # toPlot = AUX 
  # df = TEST
  
  
  nRow <- length(unlist(toPlot)) / 2
  
  mat_toPlot <- matrix(as.numeric(unlist(toPlot)), nrow = nRow)
  
  dX <- matrix(nrow = nrow(df))
  
  dY <- matrix(nrow = nrow(df))
  
  aproxX <- numeric(nRow)
  
  aproxY <- numeric(nRow)
  
  dX <- sapply(1:nRow, function(s) abs(df[,1] - mat_toPlot[s,1]))
  
  aproxX <- sapply(1:nRow, function(s) df[which.min(dX[,s]),1] )
  
  dY <- sapply(1:nRow, function(s) abs(df[,2] - mat_toPlot[s,2]))
  
  aproxY <- sapply(1:nRow, function(s) df[which.min(dY[,s]),2] )
  
  toExtract <- matrix(nrow = nRow, ncol = 2)
  
  toExtract[,1] <- aproxX
  toExtract[,2] <- aproxY
  
  # IND <- 1:length(df)
  xTemp <- which(df[,1] == toExtract[1,1])
  yTemp <- which(df[xTemp,2] == toExtract[1,2])
  # df[945,1:10]
  xyRow <- xTemp[yTemp]#df[xTemp[yTemp],1:2]
  
  list(coord = xyRow)
}

update_all <- function(session,x, choices) {
  updateSelectInput(session=session, "tab",
                    choices = choices,
                    label = "",
                    selected = x
  )
}

spRast_ValuesCoords <- function(spRaster, na_rm=FALSE){
  spPoints <- as.points(spRaster, na.rm=na_rm)
  
  spValues <- extract(spRaster, spPoints)
  
  DIM <- dim(spValues)
  
  spRasterToPoints <- as.matrix(spValues[1:DIM[1],2:DIM[2]])
  
  spCoords <- crds(spRaster, na.rm=na_rm)
  
  list(values=spRasterToPoints, coords=spCoords)  
}

LoadToEnvironment <- function(RData, env=new.env()){
  load(RData, env)
  return(env) 
}

trimRaster <- function(raster, allValues, valuesToExclude){
  
  toRemove <- setdiff(allValues, valuesToExclude)
  
  copyRaster <- raster
  
  if (length(copyRaster) != 0){
    for(i in toRemove){
      copyRaster[ raster == i ] <- NA
    }  
  }

  copyRaster
}

render_leaflet <- function(map, file, group, color, breaks){
  map %>%
    leafem::addGeotiff(
      file = file,
      group = group,
      # layerId = layerId,
      colorOptions = leafem::colorOptions(
        palette = color,
        breaks = breaks,
        na.color = "transparent"
      )
    )
}

# update_all <- function(x, choices) {
#   updateSelectInput(session, "tab",
#                     choices = choices,
#                     label = "",
#                     selected = x
#   )
# }

# getPointsLeaflet <- function(){
#   listFILES <- list.files( path = "C:/Users/inder/OneDrive/Desktop/wirarika2004/TIF/cpsClass",
#                            pattern = ".tif$",
#                            full.names = TRUE  )
#   
#   SIGN <- raster( listFILES[1] )
#   
#   TYPE <- raster( listFILES[6] )
#   
#   YEARS <- raster( listFILES[11] )
#   
#   typeSIGN <- TYPE
#   typeSIGN[ SIGN != 0 ] <- NA
#   
#   # yearSIGN <- YEARS
#   # yearSIGN[ is.na(typeSIGN) ] <- NA
#   
#   df_r <- rasterToPoints(typeSIGN) 
#   
#   datos <- matrix(nrow = nrow(df_r), ncol = 1)
#   LONG <- matrix(nrow = nrow(df_r), ncol = 1)
#   LAT <- matrix(nrow = nrow(df_r), ncol = 1)
#   
#   for(i in 1:nrow(datos)){
#     datos[[i]] <- df_r[i,3]
#     LONG[[i]] <- paste0("X: ", df_r[i,1])
#     LAT[[i]] <- paste0("Y: ", df_r[i,2])
#   }
#   #
#   trendClasses <- cut(datos, 
#                       breaks=0:8,
#                       include.lowest = TRUE,
#                       labels = c('Enverdecimiento', 'Pardeamiento', 
#                                  'Enverdecimiento sostenido', "Pardeamiento sostenido", 
#                                  'Enverdecimiento demorado', 'Pardeamiento demorado',
#                                  'Enverdecimiento a pardeamiento', 'Pardeamiento a enverdecimiento'))
#   
#   # labels = c('Greening', 'Browning', 
#   #            'Monotonic Greening', "Monotonic Browning", 
#   #            'Greening with setback', 'Browning with burst',
#   #            'Browning to Greening', 'Greening to Browning'))
#   
#   #
#   xy_sp <- SpatialPoints(cbind(df_r[,1], df_r[,2]),
#                          proj4string = CRS("+proj=sinu +lon_0=0 +x_0=0 +y_0=0 +R=6371007.181 +units=m +no_defs"))
#   # 
#   longlat_sp <- spTransform(xy_sp, CRS("+proj=longlat +datum=WGS84"))
#   
#   df <- data.frame(Longitude=longlat_sp@coords[,1],
#                       Latitude=longlat_sp@coords[,2],
#                       Classification=trendClasses,
#                       X=LONG, Y=LAT)
#   
#   myColorPal <- c("#50C878", "#C08F73", "#006B3C", #"darkseagreen2", 
#                   "#E32636", "#87A96B", "#2F221E",
#                   "#F2C185", "#66FF00")
#   
#   # then assign a palette to this using colorFactor
#   # in this case it goes from red for the smaller values to yellow and green
#   # standard stoplight for bad, good, and best
#   # dNBRCol <- colorFactor(palette = "RdYlGn", TEST$dNBR)
#   classesCol <- colorFactor(palette = myColorPal, df$Classification)
#   
#   leaflet(data=df) %>%
#     addTiles("Add Map Title Here") %>%
#     addProviderTiles("Esri.WorldImagery") %>%
#     addResetMapButton() %>%
#     # fitBounds(-103.65, 20.53, -103.45, 20.73) %>% 
#     # fitBounds(pixelio$EXT_LONLAT[1],
#     #           pixelio$EXT_LONLAT[3],
#     #           pixelio$EXT_LONLAT[2],
#     #           pixelio$EXT_LONLAT[4]) %>%
#     addCircleMarkers(
#       lng = ~Longitude,
#       lat = ~Latitude,
#       radius = 0.5,
#       fillOpacity = .1,
#       color=~classesCol(Classification),
#       popup = paste("<b>lon: </b>", round(df$Longitude, digits = 4), "<br>",
#                     "<b>lat: </b>", round(df$Latitude, digits = 4), "<br>", 
#                     "<b>Trend<br>Classification: </b>", df$Classification, "<br>")) #%>%
#   
# }
