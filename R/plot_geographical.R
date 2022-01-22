#' Plot Cloropleth Map of Covid Data
#'
#' @param covid_df dataframe containing covid data to plot
#' @param metric unquoted column name of a quantitative variable to plot
#'
#' @return plot object of cloropleth map
#' @export
#'
#' @examples
#' plot_geographical(covid_df,cases)
#'
library(geojsonio)
plot_geographical <- function(covid_df, metric) {

  if (!is.data.frame(covid_df)) {
    stop("The argument 'covid_df' should be a dataframe.")
  }
  else if (!is.numeric(covid_df |> pull({{ metric }}))) {
    stop("Metric to plot must be numeric")
  }




  if str_detect(metric,"^cumulative"):
    break


  else:
      break






}
