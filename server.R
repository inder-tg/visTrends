
function(input, output, session) {
  
  initialMapview <- reactiveValues(doMap=FALSE)
  
  getMapview <- function(){
    
    if( input$selectEcoregion == "Grandes Planicies" ){
      DIR <- 1
    }
    
    if( input$selectEcoregion == "Desiertos de América del Norte" ){
      DIR <- 2
    }
    
    if( input$selectEcoregion == "California Mediterranea" ){
      DIR <- 3
    }
    
    if( input$selectEcoregion == "Elevaciones Semiaridas Meridionales" ){
      DIR <- 4
    }
    
    if( input$selectEcoregion == "Sierras Templadas" ){
      DIR <- 5
    }

    if( input$selectEcoregion == "Selvas Cálido-Secas" ){
      DIR <- 6
    }
    # 
    # if( input$selectEcoregion == "Selvas Cálido-Humedas" ){
    #   DIR <- 1
    # }
    
    listFILES <- mixedsort(list.files(path = listDIRS_correct[DIR], 
                                      pattern = ".tif$", full.names = TRUE ))
    
    mapBASE <- leaflet() %>%
      addProviderTiles("Esri.WorldImagery")

    cont <- 0
    prueba <- paste0("test", testList[[DIR]]) # 1:length(listFILES)
    while( cont < length(listFILES) ){
      cont <- cont + 1
      MAP <- render_leaflet(map = mapBASE, 
                            file = listFILES[cont],
                            group = prueba[cont],
                            color = colPal,
                            breaks = BREAKS)
      mapBASE <- MAP
    }
    
    MAP %>%
      addResetMapButton() %>%
      addPolygons(data=shp_lonlat[[DIR]], 
                  weight = 5,
                  fill = FALSE,
                  # color = purepechas$Color,
                  # fillColor = purepechas$Color,
                  fillOpacity = 0.0125) %>% #,
                  # label = ~lapply(paste(s_lonlat$Z_SAGRADA), HTML))
      fitBounds(lng1=boundsMat[DIR,][1],
                lat1=boundsMat[DIR,][2],
                lng2=boundsMat[DIR,][3],
                lat2=boundsMat[DIR,][4]) %>%
      addLayersControl(
        overlayGroups = prueba,
        position = "bottomleft",
        options = layersControlOptions(collapsed = TRUE)
      ) %>%
      addLegend(position = "topright",
                opacity = 1,
                na.label = "",
                colors = colPal,
                labels = leafletLABELS,
                title = "Tipo de tendencia")
    
    

  }
  
  mapviewClasses <- reactive({
    mapView <- getMapview()
    
    if( initialMapview$doMap == FALSE ){
      toMap <- mapView
    }
    
    toMap
    
  })
  
  poligonio <- reactiveValues()
  
  output$visualizador <- renderLeaflet({
    mapviewClasses()
  })
  
  # observeEvent(input$pointsMap, {
  #   update_all(session=session, x="Map", 
  #              choices=c("", "Map", "trendClass"))
  # })
  
  # observeEvent(input$cpsTrend, {
  #   update_all(session=session, x="trendClass", 
  #              choices=c("", "Map", "trendClass"))
  # })
  
  # observeEvent("", {
  #   showElement("pointsMap_panel")
  #   hideElement("cpsTrend_panel")
  # }, once = TRUE)
  
  # observeEvent(input$pointsMap, {
  #   showElement("pointsMap_panel")
  #   hideElement("cpsTrend_panel")
  # })
  
  # observeEvent(input$cpsTrend, {
  #   showElement("cpsTrend_panel")
  #   showElement("pointsMap_panel")
  # })
  
  # output$box_pointsMap <- renderUI({
  #   div(
  #     style = "position: relative",
  #     tabBox(
  #       id = "box_pointsMap",
  #       width = NULL,
  #       height = 690,
  #       tabPanel(
  #         title = "Trends Map",
  #         withSpinner(
  #           leafletOutput("makeClassTrendMap", height = 600),
  #           type = 4,
  #           color = "#d33724",
  #           size = 0.7
  #         )
  #       )
  #     )
  #   )
  # })

  # output$box_cpsTrend <- renderUI({
  #   div(
  #     style = "position: relative",
  #     tabBox(
  #       id = "box_cpsTrend",
  #       width = NULL,
  #       height = 690,
  #       tabPanel(
  #         title = "ChangePoints",
  #         withSpinner(
  #           plotOutput("cpsTrendPlot", height = 450),
  #           type = 4,
  #           color = "#d33724",
  #           size = 0.7
  #         )
  #       )
  #     )
  #   )
  # })

  # initialMap <- reactiveValues(doMap=FALSE)

  # getPointsLeaflet <- function(){
  # 
  #   if( input$selectLand == "Pericos" ){
  #     if( input$selectVI == "EVI" ){
  #       DIR <- 2
  #     } else {
  #       DIR <- 3
  #     }
  #   }
  # 
  #   if( input$selectLand == "SanMiguel" ){
  #     if( input$selectVI == "NDVI" ){
  #       DIR <- 5
  #     } else {
  #       DIR <- 6
  #     }
  #   }
  # 
  #   FILES <- list.files(path = roiDIR[DIR],
  #                       pattern = ".tif$",
  #                       full.names = TRUE)
  # 
  #   RDATAfiles <- list.files(path = RDataPath[DIR],
  #                            pattern = ".RData$",
  #                            full.names = TRUE)
  # 
  #   SIGN <- raster( FILES[1] )
  # 
  #   TYPE <- raster( FILES[2] )
  # 
  #   YEARS <- raster( FILES[3] )
  # 
  #   poligonio$TYPE <- TYPE
  # 
  #   poligonio$SIGN <- SIGN
  # 
  #   typeSIGN <- TYPE
  #   typeSIGN[ SIGN != 0 ] <- NA
  # 
  #   df_r <- rasterToPoints(typeSIGN)
  #   rTp <- LoadToEnvironment(RDATAfiles[1])$rTp
  # 
  #   poligonio$rTp <- df_r
  # 
  #   poligonio$rTp_extend <- rTp
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
  #   df <- data.frame(Longitude=df_r[,1],
  #                    Latitude=df_r[,2],
  #                    Classification=trendClasses,
  #                    X=LONG, Y=LAT)
  # 
  # 
  #   # then assign a palette to this using colorFactor
  #   # in this case it goes from red for the smaller values to yellow and green
  #   # standard stoplight for bad, good, and best
  #   # dNBRCol <- colorFactor(palette = "RdYlGn", TEST$dNBR)
  #   classesCol <- colorFactor(palette = myColorPal, df$Classification)
  # 
  #   leaflet(data=df) %>%
  #     addTiles("Add Map Title Here") %>%
  #     addProviderTiles("OpenStreetMap") %>%
  #     addProviderTiles("Esri.WorldImagery") %>%
  #     addResetMapButton() %>%
  #     addCircleMarkers(
  #       lng = ~Longitude,
  #       lat = ~Latitude,
  #       radius = 0.5,
  #       fillOpacity = .1,
  #       color=~classesCol(Classification),
  #       popup = paste("<b>lon: </b>", round(df$Longitude, digits = 4), "<br>",
  #                     "<b>lat: </b>", round(df$Latitude, digits = 4), "<br>",
  #                     "<b>Trend<br>Classification: </b>", df$Classification, "<br>")) #%>%
  # }

  # drawClassMap <- reactive({
  #   pointsMap <- getPointsLeaflet()
  #   
  #   if( initialMap$doMap == FALSE ){
  #     toMap <- pointsMap
  #   }
  #   
  #   toMap
  #   
  # })
  
  # output$makeClassTrendMap <- renderLeaflet({
  #   drawClassMap()
  # })
  
  # output$cpsTrendPlot <- renderPlot({
  # 
  #   LONG <- input$makeClassTrendMap_click$lng #input$longitude_x LONG is y-axis
  #   LAT <- input$makeClassTrendMap_click$lat #input$latitude_y LAT is x-axis
  # 
  #   pixelXY <- get_timeSeries_byClicking(c(LONG, LAT),
  #                                        df = poligonio$rTp_extend$coords)$coord
  # 
  #   # print(pixelXY)
  # 
  #   tsPixel <- as.numeric(poligonio$rTp_extend$values[pixelXY,])
  # 
  #   tsPixel <- na_interpolation(tsPixel)
  # 
  #   timeSeries <- ts(as.numeric(tsPixel),
  #                    start = c(2017, 1), end = c(2023, 12),
  #                    frequency = 12)
  #   #
  #   #
  #   BFAST01 <- bfast01(timeSeries, bandwidth = 0.1)
  # 
  #   plot(BFAST01)
  # 
  # })
  
}






