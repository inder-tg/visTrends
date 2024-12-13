
# "/home/itecuapetla/Escritorio/consulting/vizzTrends"

ecoDIR <- list.dirs( path = "/home/itecuapetla/Escritorio/consulting/vizzTrends/TIF" )

# RDataPath <- list.dirs( path = "C:/Users/inder/OneDrive/Desktop/proyectoAlberto/RData" )[-1]

ecoRegions <- c("Grandes Planicies", "Desiertos de America del Norte",
                "California Mediterranea", "Elevaciones Semiaridas Meridionales",
                "Sierras Templadas", "Selvas Calido-Secas", "Selvas Calido-Humedas")

# shortEcoregions <- sort(c("califMediterranea", "desiertos", "elevaciones",
#                      "grandesPlanicies",  "selvasCalidoHumedas", "selvasCalidoSecas",
#                      "sierrasTempladas"))

shortEcoregions <- c("grandesPlanicies", "desiertos", "califMediterranea", "elevaciones",
                     "sierrasTempladas", "selvasCalidoSecas", "selvasCalidoHumedas")


colPal <- c("#b2182b", "#f3a07e", "#fce1d2",
            "#f7f0ca", "#d9e9f2", "#84bad8","#2d75be",
            "#195087")

BREAKS <- c(-Inf,-0.15,-0.07,-0.03,0,0.03,0.07,0.15,Inf)

listDIRS <- list.dirs(path = paste0( getwd(), "/TIF" ) )[-1]

# listFILES <- list.files(path = listDIRS[1], pattern = ".tif$", full.names = TRUE )



# myColorPal <- c("#50C878", "#C08F73", "#006B3C", #"darkseagreen2", 
#                 "#E32636", "#87A96B", "#2F221E",
#                 "#F2C185", "#66FF00")

# signChoices <- c("Both", "Before", "After", "None")
# 
# typeChoices <- c("Enverdecimiento", 
#                 "Pardeamiento",
#                 "Enverdecimiento sostenido",
#                 "Pardeamiento sostenido",
#                 "Enverdecimiento demorado",
#                 "Pardeamiento demorado",
#                 "Enverdecimiento a pardeamiento",
#                 "Pardeamiento a enverdecimiento")

# ---

# pathShpWirarika <- "C:/Users/inder/OneDrive/Desktop/wirarika2004/data/SHP_TERRIT_WIXA"

# ---

# shpLIST <- list.files( path = pathShpWirarika,
#                        pattern = ".shp$",
#                        full.names = TRUE )

# s <- read_sf(shpLIST[1])

# s
# plot(st_geometry(s))

# s_lonlat <- st_transform(s, crs=CRS("+proj=longlat +datum=WGS84"))

# s_lonlat$Z_SAGRADA <- c( "Teekata", "Xapawiyeme", "Haramara", "Wirikuta",
                         # "Hauxamanaka" )


# plot(st_geometry(s_lonlat[1,]))

# ---

# ---

# TXT <- c(paste0("<div class='leaflet-popup-scrolled' 
#                 style='max-width:400px;max-height:300px;background-color:lightblue;font-family:cursive,sans-serif;justify-content:center;'>
#                 <h3>Faro</h3>
#                 <img src='Haramara_1.jpeg' alt='Example Image' width='200' height=200'/>
#                     <p><font size=0.5> 
#                     En la llamada Danza de los Tigres de Coeneo se efectúa una
#                     curiosa metamorfosis: los supuestos tigres portan máscaras 
#                     hechas con la piel seca de la cara y astas del venado 
#                     se rumora que es debido a una leyenda de un hombre vio en la
#                     sierra de esta zona aun puma con astas de venado.                
#                     </font></p>
#                 </div>"), 
#          paste0("<div class='leaflet-popup-scrolled' 
#                 style='max-width:400px;max-height:300px;background-color:lightblue;font-family:cursive,sans-serif;justify-content:center;'>
#                 <h3>Playa</h3>
#                 <img src='Haramara_2.jpeg' alt='Example Image' width='200' height=200'/>
#                     <p><font size=0.5> 
#                     En la llamada Danza de los Tigres de Coeneo se efectúa una
#                     curiosa metamorfosis: los supuestos tigres portan máscaras 
#                     hechas con la piel seca de la cara y astas del venado 
#                     se rumora que es debido a una leyenda de un hombre vio en la
#                     sierra de esta zona aun puma con astas de venado.                
#                     </font></p>
#                 </div>"),
#          paste0("<div class='leaflet-popup-scrolled' 
#                 style='max-width:400px;max-height:300px;background-color:lightblue;font-family:cursive,sans-serif;justify-content:center;'>
#                 <h3>Camping</h3>
#                 <img src='Haramara_3.jpeg' alt='Example Image' width='200' height=200'/>
#                     <p><font size=0.5> 
#                     En la llamada Danza de los Tigres de Coeneo se efectúa una
#                     curiosa metamorfosis: los supuestos tigres portan máscaras 
#                     hechas con la piel seca de la cara y astas del venado 
#                     se rumora que es debido a una leyenda de un hombre vio en la
#                     sierra de esta zona aun puma con astas de venado.                
#                     </font></p>
#                 </div>"))

# ---

# icoLst <- awesomeIconList(
#   eye = makeAwesomeIcon(text = fa("eye"), iconColor = "green"),
#   fish = makeAwesomeIcon(text = fa("fish")),
#   worship = makeAwesomeIcon(text = fa("place-of-worship"))
# )

# wixarikaPoints$markers <- c("eye", "fish", "worship")


