stdcurve <- list(
  concentration = c(1, 2, 3),
  absorbance = c(0.31, 0.67, 0.88)
)

sample_data <- list(
  concentration = c(1, 2, 3),
  absorbance = c(0.15, 0.25, 0.35)
)

test_that("assayAnalysis runs UV280 and returns correct structure", {
  result <- assayAnalysis(
    assay = "uv280",
    stdcurve = stdcurve,
    stdconc = concentration,
    stdabs = absorbance,
    data = sample_data,
    absorbance = absorbance
  )
  
  expect_type(result, "list")
  expect_named(result, c("assay", "regression", "results", "plot"))
  expect_equal(result$assay, "uv280")
})

test_that("assayAnalysis runs BCA without error", {
  expect_no_error(
    assayAnalysis(
      assay = "bca",
      stdcurve = stdcurve,
      stdconc = concentration,
      stdabs = absorbance,
      data = sample_data,
      absorbance = absorbance
    )
  )
})

test_that("assayAnalysis will return an error when invalid assay is chosen", {
  expect_error(
    assayAnalysis(
      assay = "fake",
      stdcurve = stdcurve,
      stdconc = concentration,
      stdabs = absorbance,
      data = sample_data,
      absorbance = absorbance
    ),
    "assay must be one of the following"
  )
})