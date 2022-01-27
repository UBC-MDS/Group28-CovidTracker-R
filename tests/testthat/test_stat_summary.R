library(testthat)
# Tests that the function will throw an error
# when arguments are of right type but inappropriate value
df <- get_covid_data()

test_that("Error should be thrown for incorrect parameter types", {
  expect_error(calculate_stat_summary('data.frame', 'cases'))
  expect_error(calculate_stat_summary(df, 100))
  expect_error(calculate_stat_summary(df, 'newcase'))
  expect_error(calculate_stat_summary(df, 'province'))
})

# Tests that the function returns a data.frame of correct size
test_that("calculate_stat_summary() should return a tibble", {
  expect_equal(nrow(calculate_stat_summary(df, 'cases')), 14)
  expect_equal(ncol(calculate_stat_summary(df, 'cases')), 12)
})

test_that("calculate_stat_summary() should return a tibble", {
  expect_true("data.frame" %in% class(calculate_stat_summary(df, 'cases')))
  expect_true("province" %in% colnames(calculate_stat_summary(df, 'cases')))
})