test_that("assay_regression works for simple data", {
  
  test_data <- data.frame(
    conc = c(1, 2, 3),
    abs = c(0.1, 0.2, 0.3)
  )
  
  result <- assay_regression(
    data = test_data,
    concentration = conc,
    absorbance = abs
  )
  
  expect_true(is.list(result))
  expect_true("intercept" %in% names(result))
  expect_true("primary" %in% names(result))
  expect_true("secondary" %in% names(result))
})