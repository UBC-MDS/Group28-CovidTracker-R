# Tests that errors are raised when arguments are of right type but inappropriate value
test_that("Error should be thrown for incorrect parameter types", {
  expect_error(get_covid_data("tomatoes", "BC", "22-11-2021"))
  expect_error(get_covid_data("cases", "HK", "14-08-2021"))
  expect_error(get_covid_data("cases", "BC", "11-22-2021"))
})

# Tests that the function returns a data.frame of correct size 
test_that("get_covid_data() should return a tibble", {
  expect_equal(nrow(get_covid_data("cases", "", "25-08-2020")), 14)
  expect_equal(ncol(get_covid_data("cases", "", "25-08-2020")), 4)
})

test_that("get_covid_data() should return a tibble", {
  expect_true("data.frame" %in% class(get_covid_data()))
})

# Tests that the function returns the correct data for given arguments
test_df <- data.frame(cases = 974, cumulative_cases = 142347, date_report = "24-05-2021", province = "BC")
test_that("get_covid_data() should return a tibble", {
  expect_equal(get_covid_data("cases", "BC", "24-05-2021"), test_df)
})

