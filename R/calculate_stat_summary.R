#' Create summary information about the covid in each province of Canada
#'
#' @param df data.frame containing covid data to summarize
#' @param column the column name to summarize
#'
#' @return data.frame containing summary information.
#' @export
#'
#' @examples
#' df <- get_covid_data()
#' calculate_stat_summary(df,'cases')
calculate_stat_summary <- function(df, column) {

    if (! is.data.frame(df)) {
        stop("df should be an data.frame")
    }

    if (nrow(df) == 0) {
        stop("df should contain at least one row of data")
    }

    if (! 'province' %in% colnames(df)) {
        stop("The data.frame must contain 'province' column")
    }

    if (! is.character(column)) {
        stop("column name should be a string")
    }

    if (! column %in% colnames(df)) {
        stop("The column does not exist")
    }

    column <- sym(column)

    if (! is.numeric(pull(select(df, !!column)))) {
        stop("The summary column must be numeric")
    }

    # find the date column in the input data.frame, and rename it to 'date'
    columns = colnames(df)
    for (i in seq_along(columns)) {
       if (stringr::str_detect(columns[i], "date")) {
           columns[i] <- "date"
       }
    }
    colnames(df) <- columns

    # transform the date column from string to date
    df <- df |>
        mutate(date = as.Date(date, format='%d-%m-%Y'))

    # generate summary information
    summary <- df |>
        group_by(province) |>
        summarize(start_date = min(date), end_date = max(date), count = n(), sd = round(sd(!!column), 2),
                  min = min(!!column), max = max(!!column), mean = as.integer(mean(!!column)),
                  quantile_25 = quantile(!!column,0.25 ),
                  quantile_50 = quantile(!!column, 0.5),
                  quantile_75 = quantile(!!column, 0.75)) |>
        arrange(province)

    # get the current value of the column to summarize
    date_max <- max(df$date)
    current <- df |>
        filter(date == date_max) |>
        arrange(province) |>
        select(!!column) |>
        rename(current_value := !!column)

    return(cbind(summary, current))
}
