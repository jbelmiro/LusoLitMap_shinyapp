#load libraries
library(shiny)
library(leaflet)
library(dplyr)
library(leaflet.extras)
library(tidyverse)
library(sf)
library(leafpop)
library(lattice)

icons <- awesomeIcons(
  icon = "A",
  markerColor = "orange")

#RMmap

ui <- fillPage(
 leafletOutput("map", width = "100%", height = "100%"),
              tags$style(type = "text/css", "html, body {width:100%; height:100%}"),
              fluidRow(verbatimTextOutput("map_marker_click"))
    )

  
server <- function(input, output, session) {
  
  data <- read_csv("geosamples_db.csv")
 
  
  output$map <- renderLeaflet({
    leaflet() %>%
      #addTiles() %>% 
      addProviderTiles(provider = "Esri.WorldGrayCanvas") %>% 
      addMarkers(clusterOptions = markerClusterOptions(), lng = data$Longitude, lat = data$Latitude, label = data$ID, icon = icons, 
                 popup = paste("ID:", data$ID, "<br>",
                               "Site:", data$Site, "<br>",
                               "Latitude:", data$Latitude, "<br>",
                               "Longitude:", data$Longitude, "<br>",
                               "State:", data$State, "<br>"))
  })
    observeEvent(input$map_marker_click, { 
      p <- input$map_marker_click 
      print(p)
    })
}

shinyApp(ui, server)
