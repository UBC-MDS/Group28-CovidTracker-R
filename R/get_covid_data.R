library(stringr)
library(httr)
library(jsonlite)

#' Acquires Canada Covid data of specified type
#' and for an optionally provided date and province
#'
#' @param data_type string containing type of metric requested
#' @param loc string indicating province of interest
#' @param date string indicating date of interest
#'
#' @return dataframe of Covid data
#' @export
#'
#' @examples
#' get_covid_data('cases', 'BC', '13-01-2021')
get_covid_data <- function(data_type="cases", loc="", date="") {


  stat_types <- c('cases', 'mortality', 'recovered', 'testing', 'active',
                'dvaccine', 'avaccine', 'cvaccine')
  provinces <- c('AB', 'BC', 'MB', 'NB', 'NL', 'NT', 'NS', 'NU', 'ON', 'PE', 'QC', 'SK', 'YT', 'RP', '')

  if (! data_type %in% stat_types){
    stop("Stat type must be within the pre-defined options")
  }
  if (! loc %in% provinces){
    stop("Provinces must be within pre-defined options or left empty.")
  }
  if (is.na(str_extract(date, regex("(0[1-9]|[12][0-9]|3[01])-(0[1-9]|1[0-2])-\\d{4}|$^")))){
    stop("Input date must be string following the DD-MM-YYYY format")
  }


  endpoint <- "https://api.opencovid.ca/timeseries"
  params <- list(stat = data_type, loc = loc, date = date)

  res = httr::GET(endpoint, query = params)
  return(data.frame(jsonlite::fromJSON(rawToChar(res$content))[[data_type]]))
}


