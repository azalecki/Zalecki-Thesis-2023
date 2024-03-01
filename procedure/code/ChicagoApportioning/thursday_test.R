library(tidycensus)
library(tidyverse)
library(stringr)
library(sf)
library(tmap)

chi_block<-get_decennial(geography="block", state="IL", county="Cook", year=2020,
                         variables=c(block_pop="P1_001N", block_hu="H1_001N")) %>% 
  pivot_wider(id_cols = "GEOID", names_from = variable, values_from = value)

chi_tract<-get_decennial(geography="tract", state="IL", county="Cook", year=2020,
                         variables=c(tract_pop="P1_001N", tract_hu="H1_001N")) %>% 
  pivot_wider(id_cols = "GEOID", names_from = variable, values_from = value) %>% 
  arrange(GEOID)

test_weights_chi <- chi_block %>% 
  mutate(tract=substr(GEOID, 1, 11)) %>% 
  arrange(tract) %>% 
  merge(chi_tract, by.x="tract", by.y="GEOID", all.x=T) %>% 
  mutate(block=substr(GEOID, 1, 16)) %>% 
  mutate(pop_wt=block_pop/tract_pop, hu_wt=block_hu/tract_hu)

test_acs_table_wt <- test_weights_chi %>% merge(acs_table, by.x="tract", by.y="GEOID", all.x=T) %>% 
  mutate(latinx_app=pop_wt*latinx)

test_centroids <- st_centroid(chi_blocks_shp)

test_vor_blocks <- st_join(chi_vor, test_centroids, join= st_intersects, left=TRUE)

test_lib_service <- test_acs_table_wt %>% 
  merge(test_vor_blocks, by.x="GEOID", by.y="GEOID.y", all.x=T)

test_agg_latinx <- aggregate(latinx_app ~ NAME, data = test_lib_service, sum)

test_catchment <- chi_vor %>% merge(test_agg_latinx, by="NAME")

tm_latinx <-tmap_mode("plot")
tm_shape(test_catchment) +
  tm_polygons(col="latinx_app", style="jenks", title="LatinX Pop", lwd= NA, border.col="lightgrey") +
  tm_layout(legend.width=3, legend.text.size = .6, legend.title.size = .8, asp=0.8)

tm_latinx
 
