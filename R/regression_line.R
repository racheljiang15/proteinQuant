

# draft
regression_line <- function(x) {
  data <- sample_plate_reader(x)
  uv_linear <- lm(y ~ x, data = data)
  polynomial <- lm(y~x, data = data)
}

