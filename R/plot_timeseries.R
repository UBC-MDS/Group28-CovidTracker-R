#' Create a plot of the number of covid cases over time.
#'
#' @param covid_df a dataframe containing covid data to plot
#' @param metric the name of column from covid data to plot along time
#' @param start a string indicating the start date in pattern YYYY-MM-DD
#' @param end a string indicating the end date in pattern YYYY-MM-DD
#'
#' @return plot object
#' @export
#'
#' @examples
#' df <- get_covid_data()
#' plot_timeseries(df,cases)
plot_timeseries <- function(covid_df, metric, start = "", end = "") {

    metric <- enquo(metric)

    # Test input values
    if(!is.data.frame(covid_df)) {
        stop("The datatype of covid_df must be data frame.")
    }

    if(!is.character(start)) {
        stop("The datatype of start must be string.")
    }

    if(!is.character(end)) {
        stop("The datatype of end must be string.")
    }

    # if(!(metric %in% colnames(covid_df))) {
    #     stop("Chosen metric must be a column of the data.")
    # }

    # if((str_detect(metric, "date")) | (str_detect(metric, "province"))) {
    #     stop("Chosen metric must not be date or province.")
    # }

    # if(metric == "testing_info") {
    #     stop("This column is not available for plotting, please choose another column.")
    # }

    if (!is.numeric(covid_df %>% pull( !!metric ))) {
        stop("Metric column to plot must be numeric")
    }

    # Find and convert the date column
    for (i in colnames(covid_df)) {
        if(str_detect(i, "date")) {
            covid_df$new_date <- lubridate::dmy(covid_df[,i])
        }
    }

    pattern <- "^\\d{4}-\\d{2}-\\d{2}$"

    if((start != "") & (end != "")){
        if(!stringr::str_detect(start, pattern)) {
            stop("Input start date should be in pattern YYYY-MM-DD")
        } else if(!stringr::str_detect(end, pattern)) {
            stop("Input end date should be in pattern YYYY-MM-DD")
        } else {
            start <- lubridate::ymd(start)
            end <- lubridate::ymd(end)
        }

        if(end <= start) {
            stop("The start date must be before the end date.")
        }
    }

    if(isTRUE(start == "")) {
        start <- min(covid_df$new_date)
    }

    if(isTRUE(end == "")) {
        end <- max(covid_df$new_date)
    }

    data <- select(covid_df, !!metric, new_date) %>% filter(new_date <= end, new_date >= start)

    plot <- ggplot() +
        geom_line(data, mapping = aes_string('new_date', metric)) +
        xlab("Date") +
        ylab(sprintf("%s",str_to_title(str_replace(as_label(metric),"_"," ")))) +
        ggtitle(paste('Time series plot of', sprintf("%s",str_to_title(str_replace(as_label(metric),"_"," ")))))

    #plot <- ggplotly(plot)

    return (plot)
}
