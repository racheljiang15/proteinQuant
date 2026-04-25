test_that("asaay_graphing_tool returns a ggplot object", {
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