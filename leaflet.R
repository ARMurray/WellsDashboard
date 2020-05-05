leaflet(data = sd)%>%
  addTiles()%>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = ~colorQuantile("YlOrRd", Hybd_Tot_10)(Hybd_Tot_10),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))