
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CovidTrackerR

<!-- badges: start -->

[![R-CMD-check](https://github.com/UBC-MDS/Group28-CovidTracker-R/workflows/R-CMD-check/badge.svg)](https://github.com/UBC-MDS/Group28-CovidTracker-R/actions)
[![codecov](https://codecov.io/gh/UBC-MDS/Group28-CovidTracker-R/branch/main/graph/badge.svg?token=dGXh2N04A5)](https://codecov.io/gh/UBC-MDS/Group28-CovidTracker-R)
<!-- badges: end -->

CovidTrackerR provides basic data cleaning, wrangling and plotting of
Covid tracking data in Canada.

## Functions

The CovidTrackerR package is designed for the easy retrieval and
analysis of data pertaining to Covid trends in Canada, including
information about cases, vaccinations and testing. The package serves as
a wrapper for the opencovid.ca [API](Ihttps://opencovid.ca/api/), and
provides additional helper functions for visualising the data, either as
a time series or in the form of a map.

-   #### `get_covid_data()`

    Retrieve cleaned and formatted data of specified type and within
    (optionally) provided time ranges and locations

-   #### `plot_time_series()`

    Function for plotting time series trends in Covid data, including
    options for trendlines and smoothing

-   #### `calculate_stat_summary()`

    Function for returning key statistical information about Covid data,
    such as long run trends and comparisons between provinces<br>

-   #### `plot_geographical()`

    Function for plotting choropleth maps with Covid data

## Installation

You can install the development version of CovidTrackerR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Group28-CovidTracker-R")
```

## Documentation

A vignette with full usage demonstration and function documentation can
be found here <https://ubc-mds.github.io/Group28-CovidTracker-R/>

## Usage and Examples

`CovidTrackerR` can be used to acquire covid data, generate choropleth
maps and time series plots, and compute summary statistics as follows:

``` r
library(CovidTrackerR)
#> Loading required package: tidyverse
#> -- Attaching packages --------------------------------------- tidyverse 1.3.1 --
#> v ggplot2 3.3.5     v purrr   0.3.4
#> v tibble  3.1.4     v dplyr   1.0.7
#> v tidyr   1.1.3     v stringr 1.4.0
#> v readr   2.0.2     v forcats 0.5.1
#> -- Conflicts ------------------------------------------ tidyverse_conflicts() --
#> x dplyr::filter() masks stats::filter()
#> x dplyr::lag()    masks stats::lag()
covid_data <- get_covid_data('active', 'BC')
head(covid_data)
#>   active_cases active_cases_change cumulative_cases cumulative_deaths
#> 1            0                   0                0                 0
#> 2            0                   0                0                 0
#> 3            0                   0                0                 0
#> 4            1                   1                1                 0
#> 5            1                   0                1                 0
#> 6            1                   0                1                 0
#>   cumulative_recovered date_active province
#> 1                    0  25-01-2020       BC
#> 2                    0  26-01-2020       BC
#> 3                    0  27-01-2020       BC
#> 4                    0  28-01-2020       BC
#> 5                    0  29-01-2020       BC
#> 6                    0  30-01-2020       BC
```

``` r
covid_df <- get_covid_data()
plot_geographical(covid_df, cases)
#> Registered S3 method overwritten by 'geojsonsf':
#>   method        from   
#>   print.geojson geojson
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

``` r
plot_timeseries(covid_df,cases)
```

<img src="man/figures/README-unnamed-chunk-4-1.png" width="100%" />

``` r
calculate_stat_summary(covid_df,'cases')
#>         province start_date   end_date count      sd min   max mean quantile_25
#> 1        Alberta 2020-01-25 2022-02-02   740 1367.17   0 17577  674       18.00
#> 2             BC 2020-01-25 2022-02-02   740  819.15   0  9332  442        0.00
#> 3       Manitoba 2020-01-25 2022-02-02   740  440.00   0  7083  164        1.00
#> 4  New Brunswick 2020-01-25 2022-02-02   740  137.79  -2  2548   39        0.00
#> 5             NL 2020-01-25 2022-02-02   740  131.60   0  1873   24        0.00
#> 6    Nova Scotia 2020-01-25 2022-02-02   740  158.23  -1  1184   52        0.00
#> 7        Nunavut 2020-01-25 2022-02-02   740   10.59   0   140    2        0.00
#> 8            NWT 2020-01-25 2022-02-02   740   33.97  -4   314    8        0.00
#> 9        Ontario 2020-01-25 2022-02-02   740 2907.45   0 35287 1423      204.25
#> 10           PEI 2020-01-25 2022-02-02   740   49.75   0   407   11        0.00
#> 11        Quebec 2020-01-25 2022-02-02   740 2328.19 -90 17122 1173      158.00
#> 12   Repatriated 2020-01-25 2022-02-02   740    0.20   0     4    0        0.00
#> 13  Saskatchewan 2020-01-25 2022-02-02   740  253.45   0  1979  162        8.75
#> 14         Yukon 2020-01-25 2022-02-02   740   16.18   0   197    4        0.00
#>    quantile_50 quantile_75 current_value
#> 1        209.0      786.00          3024
#> 2         75.0      584.00          1774
#> 3         53.0      173.00           524
#> 4          3.0       16.00           381
#> 5          0.0        3.00           248
#> 6          2.0       17.00           395
#> 7          0.0        0.00             0
#> 8          0.0        0.00           148
#> 9        550.5     1564.50          4307
#> 10         0.0        1.00           238
#> 11       654.0     1094.75          3816
#> 12         0.0        0.00             0
#> 13        73.0      221.25           622
#> 14         0.0        1.00            18
```

## Similar Packages

There are several R packges which have some overlapping functionality as
our package, but none which perform all the data acquisition, analysis
and graphing tasks which CovidTracker encompasses. The packages designed
for covid data retrieval also do not use the same data source as
CovidTracker and do not provide the same level of granularity. Some
examples of related R packages useful for Covid data retrieval and data
visualizations include:

-   [COVID19](https://cran.r-project.org/web/packages/COVID19/index.html) -
    For Covid data retrieval
-   [covdata](https://github.com/kjhealy/covdata/) - For Covid data
    retrieval
-   [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) -
    For data visualizations
-   [tmap](https://cran.r-project.org/web/packages/tmap/index.html) -
    For choropleth data visualizations
