covid_df <- read_csv("../../R/covid_df.csv")
plot <- plot_geographical(covid_df,cases)

test_that("Incorrect input types should throw an error", {
  expect_error(plot_geographical("helper_df", cases))
  expect_error(plot_geographical(c("Apple", "Banana", "Lemons"),cases))
})

test_that("Column to plot  must be numeric", {
  expect_error(plot_geographical(covid_df, province))
})

test_that("The returned plot should be a ggplot object.", {
  expect_true(ggplot2::is.ggplot(suppressWarnings(plot_geographical(covid_df,cases))))
})

test_that('Plot should use geom_point and map x to x-axis, and y to y-axis.', {
  expect_true("GeomPolygon" %in% c(class(plot$layers[[1]]$geom)))
  expect_true("cases"  == rlang::get_expr(plot$layers[[1]]$mapping$fill))
  expect_true("long" == rlang::get_expr(plot$layers[[1]]$mapping$x))
  expect_true("lat" == rlang::get_expr(plot$layers[[1]]$mapping$y))
})
