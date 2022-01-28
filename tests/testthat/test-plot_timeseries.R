data <- get_covid_data()
plot1 <- plot_timeseries(data, cases)
plot2 <- plot_timeseries(data, cases, "2019-01-01", "2022-01-01")

# Test output data type
test_that("The returned plot should be a ggplot object.", {
    expect_true(ggplot2::is.ggplot(suppressWarnings(plot1)))
    expect_true(ggplot2::is.ggplot(suppressWarnings(plot2)))
})

# Test input date type
test_that("Chosen metric should be numeric", {
    expect_error(plot_timeseries(covid_df, province))
})

test_that("Incorrect input types should throw an error", {
    expect_error(plot_timeseries("data", cases))
})

# Test output attributes
test_that('The plot should be a line plot with converted date column as x axie', {
    expect_true("GeomLine" %in% c(class(plot2$layers[[1]]$geom)))
    expect_true("new_date" == rlang::get_expr(plot2$layers[[1]]$mapping$x))
})