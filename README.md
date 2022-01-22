
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CovidTrackerR

<!-- badges: start -->
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
    Function for plotting chloropleth maps with Covid data 

## Similar Packages   
There are several R packges which have some overlapping functionality as our package, but none which perform all the data acquisition, analysis and graphing tasks which CovidTracker encompasses. The packages designed for covid data retrieval also do not use the same data source as CovidTracker and do not provide the same level of granularity. Some examples of related R packages useful for Covid data retrieval and data visualizations include:

- [COVID19](https://cran.r-project.org/web/packages/COVID19/index.html) - For Covid data retrieval 
- [covdata](https://github.com/kjhealy/covdata/) - For Covid data retrieval
- [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) - For data visualizations
- [tmap](https://cran.r-project.org/web/packages/tmap/index.html) - For chloropleth data visualizations


## Installation

You can install the released version of CovidTrackerR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("CovidTrackerR")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/Group28-CovidTracker-R")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(CovidTrackerR)
## basic example code
```

What is special about using `README.Rmd` instead of just `README.md`?
You can include R chunks like so:

``` r
summary(cars)
#>      speed           dist       
#>  Min.   : 4.0   Min.   :  2.00  
#>  1st Qu.:12.0   1st Qu.: 26.00  
#>  Median :15.0   Median : 36.00  
#>  Mean   :15.4   Mean   : 42.98  
#>  3rd Qu.:19.0   3rd Qu.: 56.00  
#>  Max.   :25.0   Max.   :120.00
```

You’ll still need to render `README.Rmd` regularly, to keep `README.md`
up-to-date. `devtools::build_readme()` is handy for this. You could also
use GitHub Actions to re-render `README.Rmd` every time you push. An
example workflow can be found here:
<https://github.com/r-lib/actions/tree/master/examples>.

You can also embed plots, for example:

<img src="man/figures/README-pressure-1.png" width="100%" />

In that case, don’t forget to commit and push the resulting figure
files, so they display on GitHub and CRAN.
