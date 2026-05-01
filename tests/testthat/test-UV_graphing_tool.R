test_that("UV_graphing_tool returns a ggplot object", {
  test_data <- data.frame(
    conc = c(1, 2, 3, 4),
    abs = c(0.1, 0.2, 0.3, 0.4)
  )
  result <- assay_graphing_tool(
    data = test_data,
    concentration = conc,
    absorbance = abs
  )
  
  expect_s3_class(result, "ggplot")
})

test_that("UV_graphing_tool returns error when only one set of concentration was entered", {
  
  test_data <- data.frame(
    conc = 1,
    abs = c(0.1)
  )
  
  
  expect_error(
    UV_graphing_tool(
      data = test_data,
      concentration = conc,
      absorbance = abs
    ),
    "Input should include more than 1 concentration value"
  )
})


test_that("UV_grpahing_tool returns error on mismatched lengths", {
  
  test_data <- list(
    conc = c(1, 2),
    abs = c(0.1, 0.2, 0.3)
  )
  
  
  expect_error(
    UV_graphing_tool(
      data = test_data,
      concentration = conc,
      absorbance = abs
    ),
    "Each concentration must have a corresponding absorbance"
  )
})


