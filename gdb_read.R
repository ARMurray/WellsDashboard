require(rgdal)
library(sf)
library(here)
library(leaflet)

# The input file geodatabase
fgdb <- "C:/Users/HP/OneDrive - University of North Carolina at Chapel Hill/EPA_12_13_2017/Groundwater Well Use/Final Well Estimates/subsets/subsets.gdb"

# List all feature classes in a file geodatabase
subset(ogrDrivers(), grepl("GDB", name))
fc_list <- ogrListLayers(fgdb)
print(fc_list)

# Read the feature class
NCBG <- st_read(fgdb, layer = "NorthCarolina")

# Determine the FC extent, projection, and attribute information
summary(NCBG)

# View the feature class
plot(NCBG)

# Project to new epsg
st_crs(NCBG)
NCBG17N <- st_transform(NCBG,crs=2958)

NCBG84 <- st_transform(NCBG,crs=4326)

# Save it
st_write(NCBG17N, here("data/NCBG17N.gpkg"))
st_write(NCBG84, here("data/NCBG84.gpkg"))


simple <- st_simplify(NCBG84)

# Leaflet
leaflet(data = NCBG84)%>%
  addTiles()%>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              fillColor = ~colorQuantile("YlOrRd", Hybd_Tot_10)(Hybd_Tot_10),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))
