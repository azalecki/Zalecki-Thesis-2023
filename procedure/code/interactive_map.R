install.packages("pacman")
library(pacman)

pacman::p_load(tidycensus, tidyverse, sf, classInt, readr, tigris, studioapi, here, s2, pastecs, tmap, knitr, kableExtra, broom, usethis, webshoot, rstatix, RColorBrewer, leaflet, rgdal)


#set color ramps for race map

# Apply Jenks Natural Breaks classification for each group
jenks_black <- classIntervals(round(final_tbl$black_norm,2), n = 5, style = "jenks")
jenks_white <- classIntervals(round(final_tbl$white_norm,2), n = 5, style = "jenks")
jenks_asian <- classIntervals(round(final_tbl$asian_norm,2), n = 5, style = "jenks")
jenks_latinx <- classIntervals(round(final_tbl$latinx_norm,2), n = 5, style = "jenks")

# Create color palettes using Jenks breaks
qpal_black <- colorBin(palette = "Oranges", domain = final_tbl$black_norm, bins = jenks_black$brks)
qpal_white <- colorBin(palette = "Oranges", domain = final_tbl$white_norm, bins = jenks_white$brks)
qpal_asian <- colorBin(palette = "Oranges", domain = final_tbl$asian_norm, bins = jenks_asian$brks)
qpal_latinx <- colorBin(palette = "Oranges", domain = final_tbl$latinx_norm, bins = jenks_latinx$brks)


#set pop-up content
final_tbl$popup_black <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                    "% of Black Population", 
                    prettyNum(round(final_tbl$black_norm, 2), big.mark = ","))

final_tbl$popup_white <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                         "% of White Population", 
                         prettyNum(round(final_tbl$white_norm, 2), big.mark = ","))
final_tbl$popup_asian <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                               "% of Asian Population", 
                               prettyNum(round(final_tbl$asian_norm, 2), big.mark = ","))

final_tbl$popup_latinx <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                               "% of LatinX Population", 
                               prettyNum(round(final_tbl$latinx_norm, 2), big.mark = ","))

# load basemap
racemap <- leaflet() %>% 
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
  
# black population layer
  addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_black(black_norm),
              fillOpacity = 1,
              popup = ~popup_black,
              group = "Black Population per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_black, 
            values = round(final_tbl$black_norm,2),  # Remove ~ and use actual vector
            title = "Black Pop per Capita", 
            opacity = 1, 
            group = "Black Population per Capita")%>% 
  
# white population layer 
  
  addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_white(white_norm),
              fillOpacity = 1,
              popup = ~popup_white,
              group = "White Population per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_white, 
            values = round(final_tbl$white_norm,2),  # Remove ~ and use actual vector
            title = "White Pop per Capita", 
            opacity = 1, 
            group = "White Population per Capita")%>% 
  
# asian population layer 
  
addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_asian(asian_norm),
              fillOpacity = 1,
              popup = ~popup_asian,
              group = "Asian Population per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_asian, 
            values = round(final_tbl$asian_norm,2),  # Remove ~ and use actual vector
            title = "Asian Pop per Capita", 
            opacity = 1, 
            group = "Asian Population per Capita")%>% 
  
# latin population layer 
  
addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_latinx(latinx_norm),
              fillOpacity = 1,
              popup = ~popup_latinx,
              group = "LatinX Population per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
addLegend(position = "bottomright", 
            pal = qpal_latinx, 
            values = round(final_tbl$latinx_norm,2),  # Remove ~ and use actual vector
            title = "LatinX Pop per Capita", 
            opacity = 1, 
            group = "LatinX Population per Capita")%>% 
  
 addLayersControl(
    baseGroups = c("Black Population per Capita", "White Population per Capita", "Asian Population per Capita", "LatinX Population per Capita"),
    options = layersControlOptions(collapsed = F)
    )

racemap  # Display the map

econmap

#set color ramps for race map

# Apply Jenks Natural Breaks classification for each group
jenks_inpoverty <- classIntervals(round(final_tbl$pov_norm,2), n = 5, style = "jenks")
jenks_highinc <- classIntervals(round(final_tbl$hinc_norm,2), n = 5, style = "jenks")
jenks_unemployed <- classIntervals(round(final_tbl$unemp_norm,2), n = 5, style = "jenks")

# Create color palettes using Jenks breaks
qpal_inpoverty <- colorBin(palette = "Oranges", domain = final_tbl$pov_norm, bins = jenks_inpoverty$brks)
qpal_highinc <- colorBin(palette = "Oranges", domain = final_tbl$hinc_norm, bins = jenks_highinc$brks)
qpal_unemployed <- colorBin(palette = "Oranges", domain = final_tbl$unemp_norm, bins = jenks_unemployed$brks)



#set pop-up content
final_tbl$popup_pov <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                               "% of People in Poverty", 
                               prettyNum(round(final_tbl$pov_norm, 2), big.mark = ","))

final_tbl$popup_hinc <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                               "% of High Income Population", 
                               prettyNum(round(final_tbl$hinc_norm, 2), big.mark = ","))
final_tbl$popup_unemp <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                               "% of People Unemployed", 
                               prettyNum(round(final_tbl$unemp_norm, 2), big.mark = ","))

final_tbl$popup_pov <- paste("<strong>",final_tbl$NAME,"</strong>", "</br>", 
                                "% of LatinX Population", 
                                prettyNum(round(final_tbl$latinx_norm, 2), big.mark = ","))

# load basemap
econmap <- leaflet() %>% 
  addProviderTiles(providers$CartoDB.PositronNoLabels) %>%
  
  # in poverty layer
  addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_inpoverty(pov_norm),
              fillOpacity = 1,
              popup = ~popup_pov,
              group = "In Poverty per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_inpoverty, 
            values = round(final_tbl$pov_norm,2),  # Remove ~ and use actual vector
            title = "In Poverty per Capita", 
            opacity = 1, 
            group = "In Povert per Capita")%>% 
  
  # high income population layer 
  
  addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_highinc(hinc_norm),
              fillOpacity = 1,
              popup = ~popup_hinc,
              group = "High Income per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_highinc, 
            values = round(final_tbl$hinc_norm,2),  # Remove ~ and use actual vector
            title = "High Income per Capita", 
            opacity = 1, 
            group = "High Income per Capita")%>% 
  
  # unemployed population layer 
  
  addPolygons(data = final_tbl,
              stroke = TRUE, 
              weight = 0.5,
              color = "white", 
              opacity = 1, 
              fillColor = ~qpal_unemployed(unemp_norm),
              fillOpacity = 1,
              popup = ~popup_unemp,
              group = "Unemployed Population per Capita",
              highlightOptions = highlightOptions(color = "red", weight = 1.5,bringToFront = TRUE, fillOpacity = 0.5))%>% 
  addLegend(position = "bottomright", 
            pal = qpal_unemployed, 
            values = round(final_tbl$unemp_norm,2),  # Remove ~ and use actual vector
            title = "Unemployed Pop per Capita", 
            opacity = 1, 
            group = "Unemployed Population per Capita")%>% 
  
  addLayersControl(
    baseGroups = c("Unemployed Population per Capita", "High Income per Capita", "In Poverty per Capita"),
    options = layersControlOptions(collapsed = F)
  )

econmap  # Display the map


