test_that("UV280_regression runs and will return the expected structure", {
  df <- data.frame(
    concentration = c(1, 2, 3),
    absorbance = c(0.35, 0.12, 0.91)
  )
  
  result <- UV280_regression(df, concentration, absorbance)
  
  expect_type(result, "list")
  expect_true(all(c("intercept", "primary", "secondary", "avg_data") %in% names(result)))
})

test_that("UV280_regression will return an error on mismatching lengths", {
  df <- list(
    concentration = c(1, 2, 3),
    absorbance = c(0.67, 0.2)
  )
  
  expect_error(UV280_regression(df, concentration, absorbance))
})


test_that("UV280_regression prints output when stats = TRUE", {
  df <- data.frame(
    concentration = c(1, 2, 3),
    absorbance = c(0.21, 0.67, 0.55)
  )
  
  expect_output(
    UV280_regression(df, concentration, absorbance, stats = TRUE)
  )
})

test_that("UV280_regression calculates the expected approximate slope", {
    df <- data.frame(
      concentration = c(1, 2, 3),
      absorbance = c(0.3, 0.22, 0.67)
    )
    
    result <- UV280_regression(df, concentration, absorbance)
    
    expect_equal(result$primary, 0.185)
  })

test_that("assay_regression returns error when only one set of concentration was entered", {
  
  test_data <- data.frame(
    conc = 1,
    abs = c(0.1)
  )
  
  
  expect_error(
    UV280_regression(
      data = test_data,
      concentration = conc,
      absorbance = abs
    ),
    "Input should include more than 1 concentration value"
  )
})