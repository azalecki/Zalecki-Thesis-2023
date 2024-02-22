#getting tract and block information for Cook county

library(tidycensus)
library(tidyverse)
library(stringr)


load_variables(2020, "pl")

chi_block<-get_decennial(geography="block", state="IL", county="Cook", year=2020,
                         variables=c(block_pop="P1_001N", block_hu="H1_001N")) %>% 
  pivot_wider(id_cols = "GEOID", names_from = variable, values_from = value)

chi_tract<-get_decennial(geography="tract", state="IL", county="Cook", year=2020,
                         variables=c(tract_pop="P1_001N", tract_hu="H1_001N")) %>% 
  pivot_wider(id_cols = "GEOID", names_from = variable, values_from = value) %>% 
  arrange(GEOID)

weights<-chi_block %>% 
  mutate(tract=substr(GEOID, 1, 11)) %>% 
  arrange(tract) %>% 
  merge(chi_tract, by.x="tract", by.y="GEOID", all.x=T) %>% 
  rename(block=GEOID) %>% 
  mutate(pop_wt=block_pop/tract_pop, hu_wt=block_hu/tract_hu)
