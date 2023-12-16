# Analysis of Neighborhood Characteristics of Library Catchment Areas in Chicago, IL

### Authors

- Alexandra "Ola" Zalecki, aezalecki@gmail.com, @azalecki, [ORCID link](https://orcid.org/0009-0009-6707-3136), Middlebury College

### Abstract

Rising inequality and increased privatization of space in urban landscapes are bringing attention to some of the only public spaces left: libraries. This study analyzes to what extent library service areas differ along lines of inequality like race, class, etc. This study will delineate library catchment areas in Chicago, IL, and compare them with socio-economic data at the tract and block level. This analysis is the first part of a two-pronged method that aims to explore how public library services reflect the characteristics of their local neighborhoods. 

### Study Metadata

- `Key words`: public space, libraries, population-weighted aggregation, service areas, demographics 
- `Subject`: Social and Behavioral Sciences: Geography: Human Geography
- `Date created`: 11/28/2023
- `Date modified`: 12/12/2023
- `Spatial Coverage`: Chicago, IL
- `Spatial Resolution`: Census Tracts, Census Blocks, Library Service Areas
- `Spatial Reference System`: EPSG:32616 
- `Temporal Coverage`: 2017-Present
- `Temporal Resolution`: Specify the temporal resolution of your study---i.e. the duration of time for which each observation represents or the revisit period for repeated observations

## Study design

This workflow is the first part of my senior research project that explores the question of how library service catchment areas differ along demographic lines in Chicago, IL. This workflow was originally part of my independent research work with Professor Peter Nelson during the Fall semester of 2023 which I created and implemented in QGIS.To improve the methods for this research and make it reproducible/replicable I decided to reproduce the QGIS workflow in R Studio. 

This part of the study will accomplish the following:
1.	Locate libraries in Chicago, IL and delineate their service areas.
2.	Characterize the neighborhoods that they serve using socioeconomic and demographic data. 

Because the final objective of my senior research project is to explore the services and programmatic differences between Chicago's library branches, the results of this study will be used to draw comparisons between a library and the neighborhood it serves and identify library branches in particularly distinct neighborhoods. 

## Materials and procedure

### Computational environment

This study will be completed using The R Project for Statistical Computing v.[4.3.2] or later. The research will be completed on the Windows 10 operating system. A complete list of required R packages will be reported with the final report. 

### Data and variables

Socioeconomic data at the census tract level is derived from the American Community Survey 5-year estimates (released in 2021) collected by the US Census Bureau. 

Population data at the census block level is derived from the US Decennial Census(released in 2020) collected by the US Census Bureau.

### Chicago Shapefile  
- `Abstract`: TIGER/Line shapefile of the city boundaries of Chicago, IL. Does not include any demographic data. 
- `Spatial Coverage`: Chicago, IL
- `Spatial Resolution`: Census-designated place
- `Spatial Reference System`: EPSG:32616
- `Temporal Coverage`: 2017-2021
- `Temporal Resolution`: N/A
- `Lineage`: Retrieved using the [Tigris](https://github.com/walkerke/tigris) R package
- `Distribution`: Distributed by the [US Census Bureau](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html)
- `Constraints`: Legal constraints for *access* or *use* to protect *privacy* or *intellectual property rights*
- `Data Quality`: Quality unknown

- [ ] data is not available yet
- [ ] data is available, but only metadata has been observed
- [X] metadata and descriptive statistics have been observed
- [ ] metadata and a pilot test subset or sample of the full dataset have been observed
- [ ] the full dataset has been observed. Explain how authors have already manipulated / explored the data.

#### American Community Survey(ACS) Demographic Data 

**Standard Metadata**

- `Abstract`: [The American Community Survey](https://www.census.gov/data/developers/data-sets/acs-5year.html) provides data yearly regarding the social, economic, demographic, and housing characteristics of the US population. This study will pull from several subject tables that will then be grouped by Tract ID. 
- `Spatial Coverage`: Cook County, IL
- `Spatial Resolution`: Census tracts
- `Spatial Reference System`: EPSG:32616
- `Temporal Coverage`: 2017-2021
- `Temporal Resolution`: N/A
- `Lineage`: Retrieved using the [Tidycensus](https://github.com/walkerke/tidycensus) R package
- `Distribution`: Distributed by the US Census Bureau
- `Constraints`: Legal constraints for *access* or *use* to protect *privacy* or *intellectual property rights*
- `Data Quality`: Quality unknown

- [ ] data is not available yet
- [ ] data is available, but only metadata has been observed
- [X] metadata and descriptive statistics have been observed
- [ ] metadata and a pilot test subset or sample of the full dataset have been observed
- [ ] the full dataset has been observed. Explain how authors have already manipulated / explored the data.


#### Population Data and Census Blocks for Cook County, IL  

**Standard Metadata**

- `Abstract`: Brief description of the data source
- `Spatial Coverage`: Cook County, IL
- `Spatial Resolution`: Census Blocks
- `Spatial Reference System`: EPSG:32616
- `Temporal Coverage`: 2010-2020
- `Temporal Resolution`: N/A
- `Lineage`: Retrieved using the [Tidycensus](https://github.com/walkerke/tidycensus) R package
- `Distribution`: [TIGER/Line](https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html) shapefiles are distributed by the US Census Bureau
- `Constraints`: Legal constraints for *access* or *use* to protect *privacy* or *intellectual property rights*
- `Data Quality`: Quality unknown
- `Variables`: For each variable, enter the following information. If you have two or more variables per data source, you may want to present this information in table form (shown below)
  - `Label`: POP20
  - `Alias`: Total Population
  - `Definition`: 2020 Census population count
  - `Type`: Integer
  - `Accuracy`: N/A
  - `Domain`: Range (Maximum and Minimum) of numerical data, or codes or categories of nominal data, or reference to a standard codebook
  - `Missing Data Value(s)`: Values used to represent missing data and frequency of missing data observations
  - `Missing Data Frequency`: N/A

- [ ] data is not available yet
- [ ] data is available, but only metadata has been observed
- [X] metadata and descriptive statistics have been observed
- [ ] metadata and a pilot test subset or sample of the full dataset have been observed
- [ ] the full dataset has been observed. Explain how authors have already manipulated / explored the data.

#### Public Library Locations

**Standard Metadata**

- `Abstract`: Data table of Chicago Public Library locations (addresses and long/lat coordinates), usual hours of operation, websites, and contact information 
- `Spatial Coverage`: Chicago, IL
- `Spatial Resolution`: Library address points
- `Spatial Reference System`: EPSG:32616
- `Temporal Coverage`: N/A
- `Temporal Resolution`: N/A
- `Lineage`: Retrieved from the [City of Chicago Data Portal](https://data.cityofchicago.org/Education/Libraries-Locations-Contact-Information-and-Usual-/x8fc-8rcq/data)
- `Distribution`: Data owned and provided by the [Chicago Public Library](
http://chipublib.org). Retrieved from the [City of Chicago Data Portal](https://data.cityofchicago.org/Education/Libraries-Locations-Contact-Information-and-Usual-/x8fc-8rcq/data)c
- `Constraints`: Legal constraints for *access* or *use* to protect *privacy* or *intellectual property rights*
- `Data Quality`: Quality unknown

- [ ] data is not available yet
- [ ] data is available, but only metadata has been observed
- [X] metadata and descriptive statistics have been observed
- [ ] metadata and a pilot test subset or sample of the full dataset have been observed
- [ ] the full dataset has been observed. Explain how authors have already manipulated / explored the data.

### Bias and threats to validity

**Edge/shape effects when creating polygons to represent library service/catchment areas**

Visualizing catchment areas for libraries is my first objective because, unlike primary schools that have definite attendance boundaries, libraries do not have proper "service areas." In the past, Thiessen/Voronoi polygons have been used to map catchment or service areas by proximity to points. As explained by Flitter et al(nd), GIS tools that generate Thiessen polygons draw shapes around a layer of point data where every location within one shape is nearer to its center point than all other points in the layer. These proximal regions assume that people are more likely to visit the library closest to them and as a result library services should reflect their local constituents. I recognize that this method has its flaws because this is not always the case. Some people may frequent libraries outside of their residential neighborhood for a variety of reasons and there is no way of accurately tracking that. The other option would be to draw buffers around library points like in the method we saw in the Kang et al. (year) study or calculate a network analysis. Thiessen polygons are, however, the simpler and computationally less intense option to a full-on network analysis. Although they might seem arbitrary I have attempted to improve the validity by including a population-weighted aggregation to more accurately estimate the neighborhood characteristics of the library service areas.

### Data transformations

The workflow with data transformations will be reported with the final report.

### Analysis

For the analysis of this study I will be generating simple summaries about the social, economic and demographic data joined to the library service areas.


## Results

Descriptive statistics and a map of the library catchment areas will be how the results will be presented. 

## Integrity Statement

The author of this preregistration state that they completed this preregistration to the best of their knowledge and that no other preregistration exists pertaining to the same hypotheses and research.

## Acknowledgements

This report is based upon the template for Reproducible and Replicable Research in Human-Environment and Geographical Sciences, DOI:[10.17605/OSF.IO/W29MQ](https://doi.org/10.17605/OSF.IO/W29MQ)

References 
Flitter, H., Weckenbrock, P., & Weibel, R. (n.d.). Thiessen Polygon. Retrieved December 16, 2023, from http://www.gitta.info/Accessibilit/en/html/UncProxAnaly_learningObject4.html

