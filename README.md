
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CovidTrackerR

<!-- badges: start -->
[![R-CMD-check](https://github.com/UBC-MDS/Group28-CovidTracker-R/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/Group28-CovidTracker-R/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/Group28-CovidTracker-R/branch/master/graph/badge.svg?token=dGXh2N04A5)](https://codecov.io/gh/UBC-MDS/Group28-CovidTracker-R)
<!-- badges: end -->

CovidTrackerR provides basic data cleaning, wrangling and plotting of Covid tracking data in Canada.

## Functions
The CovidTrackerR package is designed for the easy retrieval and analysis of data pertaining to Covid trends in Canada, including information about cases, vaccinations and testing. The package serves as a wrapper for the opencovid.ca [API](Ihttps://opencovid.ca/api/), and provides additional helper functions for visualising the data, either as a time series or in the form of a map. 

* #### `get_covid_data()`
    Retrieve cleaned and formatted data of specified type and within (optionally) provided time ranges and locations

* #### `plot_time_series()`
    Function for plotting time series trends in Covid data, including options for trendlines and smoothing

* #### `calculate_stat_summary()`
    Function for returning key statistical information about Covid data, such as long run trends and comparisons between provinces<br>

* #### `plot_geographical()`
    Function for plotting choropleth maps with Covid data 

## Similar Packages   
There are several R packges which have some overlapping functionality as our package, but none which perform all the data acquisition, analysis and graphing tasks which CovidTracker encompasses. The packages designed for covid data retrieval also do not use the same data source as CovidTracker and do not provide the same level of granularity. Some examples of related R packages useful for Covid data retrieval and data visualizations include:

- [COVID19](https://cran.r-project.org/web/packages/COVID19/index.html) - For Covid data retrieval 
- [covdata](https://github.com/kjhealy/covdata/) - For Covid data retrieval
- [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) - For data visualizations
- [tmap](https://cran.r-project.org/web/packages/tmap/index.html) - For choropleth data visualizations


## Installation

You can install the development version of CovidTrackerR from [GitHub](https://github.com/) with:
 
``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Group28-CovidTracker-R")
```
