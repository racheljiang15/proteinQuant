#' Standard Curve Polynomial Regression Fitting
#'
#' @description A function that returns the polynomial regression equations for BCA/ Bradford standard curves.
#' @return A regression equation with protein concentration as y and absorbance as x.
#' @export
#' @import dplyr
#' @examples
#' data(bca_bradford_bsa_standard_curve)
#' sample_data <- bca_bradford_bsa_standard_curve
#' assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance, stats = TRUE)
#'

# added argument `stats`, which is `FALSE` by default. Allows user to choose to see additional statistics by setting stats` to `TRUE`
assay_regression <- function(data, concentration, absorbance, stats = FALSE){
  avg_data <- data |>
    group_by({{ concentration }}) |>
    reframe(avg_absorbance = mean({{ absorbance }}))
  
  conc <- deparse(substitute(concentration))
  formula <- as.formula(paste(conc, "~ poly(avg_absorbance, 2)"))
  
  regression <- lm(formula, data = avg_data)
  coeffs <- coef(summary(regression))
  
  equation <- paste0(
    conc, " = ",
    round(coeffs[1], 4), " + ",
    round(coeffs[2], 4), "x + ",
    round(coeffs[3], 4), "x^2"
  )
  
  cat("Equation:", equation, "\n\n")
  
  if (stats == TRUE){
    print(coeffs)
  }
  
  intercept <- round(coeffs[1], 4)
  primary <- round(coeffs[2], 4)
  secondary<- round(coeffs[3], 4)
  
  return(list(intercept = intercept, primary = primary, secondary = secondary, avg_data = avg_data))
}

#sample_data <- bca_bradford_bsa_standard_curve
#assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance, stats = TRUE)



