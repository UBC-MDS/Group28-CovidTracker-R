library(stringr)
library(dplyr)
#' Creates summary information about the covid cases in each province of Canada
#'
#' @param df: data.frame containing covid data to summarize
#' @param column: the column name to summarize
#'
#' @return data.frame containing summary information.
#' @export
#'
#' @examples
#' calculate_stat_summary(covid_df, 'cases')
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
    
    columns = colnames(df)
    for (i in seq_along(columns)) {
       if (str_detect(columns[i], "date")) {
           columns[i] <- "date"
       }
    }
    colnames(df) <- columns

    df <- df |>
        mutate(date = as.Date(date, format='%d-%m-%Y'))

#     column <- sym(column)

    summary <- df |>
        group_by(province) |>
        summarize(start_date = min(date), end_date = max(date), count = n(), sd = round(sd(!!column), 2), 
                  min = min(!!column), max = max(!!column), mean = as.integer(mean(!!column)),
                  quantile_25 = quantile(!!column,0.25 ),
                  quantile_50 = quantile(!!column, 0.5),
                  quantile_75 = quantile(!!column, 0.75)) |>
        arrange(province)

    date_max <- max(df$date)
    current <- df |>
        filter(date == date_max) |>
        arrange(province) |>
        select(!!column) |>
        rename(current_value := !!column)
    return(cbind(summary, current))
}