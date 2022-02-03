#' Plot Cloropleth Map of Covid Data
#'
#' @param covid_df dataframe containing covid data to plot
#' @param metric unquoted column name of a quantitative variable to plot
#'
#' @return plot object of cloropleth map
#' @export
#'
#' @examples
#' covid_df <- get_covid_data()
#' plot_geographical(covid_df, cases)
plot_geographical <- function(covid_df, metric) {

  metric <- rlang::enquo(metric)


  # Check input parameters are correct type
  if (!is.data.frame(covid_df)) {
    stop("The value of the argument 'covid_df' must be of type dataframe.")
  }
  # else if (as_label(metric) %in% colnames(covid_df)) {
  #   stop("Chosen metric must be a column in the dataframe")
  # }
  else if (!is.numeric(covid_df %>% pull( !!metric ))) {
    stop("Metric column to plot must be numeric")
  }

  #Read in and tidy geodataframe containing Canada geography data
  spdf <- geojsonio::geojson_read("https://raw.githubusercontent.com/codeforgermany/click_that_hood/main/public/data/canada.geojson",  what = "sp")%>%
    broom::tidy(region = "name")
  spdf <- spdf%>%
    rename(province = id)%>%
    mutate(province=str_replace_all(province,c('Newfoundland and Labrador' = 'NL',
                                               'Prince Edward Island' = 'PEI',
                                               'British Columbia' = 'BC',
                                               'Northwest Territories' ='NWT')))

  #Data wrangling if cumulative metric is chosen
  if (stringr::str_detect(metric, "^cumulative")[1]){
    for (met in colnames(covid_df)){
      if (stringr::str_detect(metric, "^date")){
        date_metric = met
        break
      }
    }
    covid_df[[date_metric]] <- lubridate::dmy(covid_df[[date_metric]] )# convert date column to datetime
    covid_df <- covid_df%>%
      filter(covid_df[[date_metric]] == max(covid_df[[date_metric]]))# filter for most recent date
}
  #Data wrangling if non cumulative metric is chosen
  else {
    covid_df <- covid_df%>%
      group_by(province)%>%
      select_if( is.numeric) %>%
      summarise(across(everything(), sum))
    merged<-left_join(spdf,covid_df,by="province")

  }


  #Plot Chloropleth Map
  plot <- ggplot() +
    geom_polygon(data = merged, aes(fill=!!metric, x = long, y = lat, group = group),color="grey") +
    theme_void() +
    scale_fill_continuous(
      low = "ivory",high = "red4",
      guide=guide_colorbar(barwidth = 1,barheight = 14,title.position = "left"))+
    labs(fill = sprintf("%s",str_to_title(str_replace(as_label(metric),"_"," "))),
         title = sprintf("Covid Numbers Across Canada: %s",str_to_title(str_replace(as_label(metric),"_"," "))))+
    theme(legend.title = element_text(angle = 270,face = 'bold'),
          plot.title = element_text(size = 18, face = "bold"))+
    coord_map()

  return (plot)

}
