#

source("auxPKG.R")
source("auxFUN.R")
source("auxOBJ.R")

ui <- dashboardPage(
  dashboardHeader(title = 'visTrends'),
  
  dashboardSidebar(
    
    tags$style(".fa-home {color:#2ca25f}
               .fa-readme {color:#2ca25f}
               .fa-book-open {color:#2ca25f}
               .fa-book-reader {color:#2ca25f}
               .fa-map {color:#2ca25f}
               .fa-scroll {color:#2ca25f}
               .fa-play {color:##fff}
               .fa-caret-square-right {color:#2ca25f}
               .fa-hand-pointer {color:#2ca25f}
               .fa-cloudversify {color:#2ca25f}
               .fa-chalkboard-teacher {color:#2ca25f}
               .fa-chart-area {color:#2ca25f}
               .fa-chart-line {color:#2ca25f}
               .fa-envelope {color:#2ca25f}
               .fa-github {color:#2ca25f}
               .fa-r-project {color:#2ca25f}
               .fa-eye {color:#2ca25f}"
    ),
    
    sidebarMenu(
      # menuItem("Introduction", tabName = "intro", icon = icon("home")),
      menuItem("Ecoregions", tabName = "ECO", icon = icon("eye")),
      menuItem("Contact", tabName = "contactUs", icon = icon("envelope"))
    )
  ),
  
  dashboardBody(
    
    tags$head(
      tags$style(
        HTML("
          .select-container {
             display: flex;
             align-items: right;
          }
          .select-container label {
            margin-right: 2px;
            margin-left: 7px;
          }
          .select-container select {
            max-height: 25px;
            max-width: 25px;
            overflow-y: auto;
          }
          
          .leaflet-marker-content-wraper {
            background: black;
            color: #ffffff;
            padding: 2px;
            border-radius: 0px;
          }
          
          # .small-font {
          #   font-size: 12px;
          # }
             "
        )
      )
    ),
    
    useShinyjs(),
    introjsUI(),
    
    tabItems(
      
      # tabItem("intro",
      #         # fluidRow(
      #         #   column(3, wellPanel(
      #         #     p("Wirarika Territory Map"))
      #         #   )
      #         # ),
      #         
      #         fluidRow(
      #           div(
      #             class = "select-container",
      #             tags$label(" Choose a ROI", `for` = "selectROI"),
      #             tags$style("input[type=select] {transform: scale(.6);}"),
      #             tags$style("#introSelectROI {font-size:10px;height:10px;}"),
      #             column(2,
      #                    selectInput("introSelectROI", NULL,
      #                                choices = c("Pericos", "SanMiguel"))
      #             ),
      #             # tags$label(" Vegetation Index", `for` = "introSelectVI"),
      #             # column(2,
      #             #        selectInput("introSelectVI", NULL,
      #             #                    choices = c("EVI", "NDVI"))
      #             #        # checkboxGroupInput("VI", "Vegetation Index",
      #             #        #                    c("EVI", "NDVI"), selected = "EVI")
      #             # ),
      #             # tags$label(" Vegetation Index", `for` = "introSelectVI")
      #             # tags$style("input[type=checkbox] {transform: scale(.6);}"),
      #             # tags$style("#SIGN {font-size:10px;height:10px;}"),
      #             # column(2,
      #             #   checkboxGroupInput("SIGN", "Relevant segment(s)",
      #             #                      c("Both", "Before", "After", "None"),
      #             #                      selected = "Both",
      #             #                      inline = TRUE)
      #             # ),
      #             # tags$style("input[type=checkbox] {transform: scale(.6);}"),
      #             # tags$style("#TYPE {font-size:10px;height:10px;}"),
      #             # column(2,
      #             #   checkboxGroupInput("TYPE", "Trend classes",
      #             #                      c("Enverdecimiento", 
      #             #                        "Pardeamiento",
      #             #                        "Enverdecimiento sostenido",
      #             #                        "Pardeamiento sostenido",
      #             #                        "Enverdecimiento demorado",
      #             #                        "Pardeamiento demorado",
      #             #                        "Enverdecimiento a pardeamiento",
      #             #                        "Pardeamiento a enverdecimiento"),
      #             #                      selected = c("Enverdecimiento", "Pardeamiento",
      #             #                                   "Enverdecimiento sostenido",
      #             #                                   "Pardeamiento sostenido",
      #             #                                   "Enverdecimiento demorado",
      #             #                                   "Pardeamiento demorado",
      #             #                                   "Enverdecimiento a pardeamiento",
      #             #                                   "Pardeamiento a enverdecimiento"),
      #             #                      inline = FALSE)
      #             # )
      #           )
      #         ),
      #         
      #         
      #         fluidRow(
      #           column(6, wellPanel(
      #             leafletOutput("visualizador", width = "100%", height = 400))
      #           )
      #         ),
      #         
      #         br()
      # ),
      # 
      tabItem("ECO",
              
              fluidRow(
                div(
                  class = "select-container",
                  tags$label(" Choose an Ecoregion", `for` = "selectEcoregion"),
                  column(2,
                         selectInput("selectEcoregion", NULL,
                                     choices = c("Grandes Planicies", "Desiertos de América del Norte",
                                                 "California Mediterranea", "Elevaciones Semiaridas Meridionales",
                                                 "Sierras Templadas", "Selvas Cálido-Secas"),
                                                 # , 
                                                 # "Selvas Cálido-Humedas"),
                                     selected = "California Mediterranea")
                  ),
                  # tags$label(" Vegetation Indx", `for` = "selectVI"),
                  # column(2,
                  #        selectInput("selectVI", NULL,
                  #                    choices = c("EVI", "NDVI"))
                  # )
                )

              ),
              
              # fluidRow(
              #   column(8, wellPanel(
              #     leafletOutput("visualizador", width = "100%", height = 600))
              #   )
              # )
              
              fluidRow(
                column(8, withSpinner(
                  leafletOutput("visualizador", width = "100%", height = 600),
                  type=4,
                  color="#d33724",
                  size=0.7)
                )
              )
              
              
              
              # fluidRow(
              #   column(6, #wellPanel(
              #          introBox(
              #            bsButton("pointsMap",
              #                     label = "Regional",
              #                     icon = icon("map"),
              #                     style = "info",
              #                     size = "small"
              #            ),
              #            
              #            bsButton("cpsTrend",
              #                     label = "Local",
              #                     icon = icon("chart-line"),
              #                     # style = "success",
              #                     size = "small"
              #            )
              #          )
              #          # )
              #          
              #   )
              # ),
              
              # fluidRow(
              #   div(
              #     id = "pointsMap_panel",
              #     column(6, wellPanel(
              #       uiOutput("box_pointsMap"))
              #     )
              #   ),
              #   
              #   div(
              #     id="cpsTrend_panel",
              #     column(6, wellPanel(
              #       uiOutput("box_cpsTrend"))
              #     )
              #   )
              # )
              
      ),
      
      tabItem("contactUs",
              fluidRow(
                column(8,
                       p("For additional information about the dataset, trend analysis and ecoregions,
                         please contact to Luis Valderrama (lvalderr@conabio.gob.mx)."
                       ),
                       p("Should you have a comment about this shiny app, please contact to",
                         a(href="https://irt466.wixsite.com/inder", "Inder Tecuapetla"),
                         "(itecuapetla@conabio.gob.mx)"
                       )
                )
              )
      )
    )
  )
)

