test_that("assayGraph returns a ggplot object", {
  test_data <- data.frame(
    abs = c(0.1, 0.2, 0.3),
    conc = c(1, 2, 3)
  )
  result <- assayGraph(
    data = test_data,
    absorbance = abs,
    concentration = conc
  )
  
  expect_s3_class(result, "ggplot")
})