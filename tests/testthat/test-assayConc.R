test_that("assayConc calculates expected values for UV280", {
  test_data <- list(
    concentration = c(10, 20, 30),
    absorbance = c(1, 2, 3)
  )
  
  fake_regression <- list(
    intercept = 1,
    primary = 2,
    secondary = 0
  )
  
  result <- assayConc(
    data = test_data,
    absorbance = absorbance,
    regression = fake_regression,
    printWell = FALSE
  )
  
  expect_equal(result$Concentration, c(3, 5, 7))
})

test_that("assayConc calculates expected values for BCA/Bradford", {
  test_data <- list(
    concentration = c(1, 2, 3),
    absorbance = c(1, 2, 3)
  )
  
  fake_regression <- list(
    intercept = 0,
    primary = 1,
    secondary = 1
  )
  
  result <- assayConc(
    data = test_data,
    absorbance = absorbance,
    regression = fake_regression,
    printWell = FALSE
  )
  
  expect_equal(result$Concentration, c(2, 6, 12))
})

test_that("assayConc treats NA secondary as a zero", {
  test_data <- list(
    concentration = c(1, 2),
    absorbance = c(1, 2)
  )
  
  fake_regression <- list(
    intercept = 1,
    primary = 2,
    secondary = NA
  )
  
  result <- assayConc(
    data = test_data,
    absorbance = absorbance,
    regression = fake_regression,
    printWell = FALSE
  )
  
  expect_equal(result$Concentration, c(3, 5))
})

test_that("assayConc returns a data frame", {
  test_data <- list(
    concentration = c(1, 2),
    absorbance = c(1, 2)
  )
  
  fake_regression <- list(
    intercept = 0,
    primary = 1,
    secondary = 0
  )
  
  result <- assayConc(
    data = test_data,
    absorbance = absorbance,
    regression = fake_regression,
    printWell = FALSE
  )
  
  expect_s3_class(result, "data.frame")
})


test_that("assayConc returns error when only one set of concentration was entered", {
  
  test_data <- data.frame(
    abs = c(0.1)
  )
  
  fake_regression <- list(
    intercept = 0,
    primary = 1,
    secondary = 0
  )
  
  expect_error(
    assayConc(
      data = test_data,
      absorbance = abs,
      regression = fake_regression,
      printWell = FALSE
    ),
    "Input should include more than 1 absorbance value"
  )
})




