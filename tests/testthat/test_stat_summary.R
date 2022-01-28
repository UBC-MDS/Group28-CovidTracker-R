library(testthat)
library(dplyr)
# Tests that the function will throw an error
# when arguments are of right type but inappropriate value
df <- data.frame(province = c("BC", "AB", "BC", "AB"),
                 date_report = c("26-01-2022", "26-01-2022", "25-01-2022", "25-01-2022"),
                 cases = c(1000, 800, 1500, 600),
                 cumulative_cases = c(100000, 80000, 99000, 79200))

missing_df <- data.frame(date_report = c("26-01-2022", "26-01-2022"),
                  cases = c(1000, 800),
                  cumulative_cases = c(100000, 80000))

empty_df <- data.frame(province = character(),
                       date_report = character(),
                       cases = integer(),
                       cumulative_cases = integer())

test_that("Error should be thrown for incorrect parameter types", {
  expect_error(calculate_stat_summary('data.frame', 'cases'))
  expect_error(calculate_stat_summary(df, 100))
  expect_error(calculate_stat_summary(df, 'newcase'))
  expect_error(calculate_stat_summary(df, 'province'))
  expect_error(calculate_stat_summary(missing_df, 'cases'))
  expect_error(calculate_stat_summary(empty_df, 'cases'))
})

# Tests that the function returns a data.frame of correct size
test_that("calculate_stat_summary() should return a tibble", {
  expect_equal(nrow(calculate_stat_summary(df, 'cases')), 2)
  expect_equal(ncol(calculate_stat_summary(df, 'cases')), 12)
  expect_true("province" %in% colnames(calculate_stat_summary(df, 'cases')))
  expect_true("start_date" %in% colnames(calculate_stat_summary(df, 'cases')))
  expect_true("end_date" %in% colnames(calculate_stat_summary(df, 'cases')))
})

test_that("calculate_stat_summary() should return a tibble", {
  expect_true("data.frame" %in% class(calculate_stat_summary(df, 'cases')))
})
