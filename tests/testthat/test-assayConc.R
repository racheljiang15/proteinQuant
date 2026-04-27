test_that("assayConc calculates expected values", {
  test_data <- data.frame(
    abs = c(1, 2, 3)
  )
  
  fake_regression <- list(
    intercept = 1,
    primary = 2,
    secondary = 0
  )
  
  result <- assayConc(
    data = test_data,
    absorbance = abs,
    regression = fake_regression
  )
  
  expect_equal(result$Concentration, c(3, 5, 7))
})
