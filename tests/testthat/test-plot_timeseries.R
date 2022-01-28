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
test_that('Plot should use geom_point and map x to x-axis, and y to y-axis.', {
    expect_true("GeomLine" %in% c(class(plot2$layers[[1]]$geom)))
    expect_true("long" == rlang::get_expr(plot2$layers[[1]]$mapping$x))
    expect_true("lat" == rlang::get_expr(plot2$layers[[1]]$mapping$y))
})