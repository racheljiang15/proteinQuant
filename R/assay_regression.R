#' Standard Curve Polynomial Regression Fitting
#'
#' @description A function that returns the polynomial regression equations for BCA/ Bradford standard curves.
#' @return A regression equation with protein concentration as y and absorbance as x.
#' @export
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @param stats True or False.
#' @import dplyr
#' @examples
#' data(bca_bradford_bsa_standard_curve)
#' sample_data <- bca_bradford_bsa_standard_curve
#' assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance, stats = TRUE)
#'

# added argument `stats`, which is `FALSE` by default. Allows user to choose to see additional statistics by setting stats` to `TRUE`
assay_regression <- function(data, concentration, absorbance, stats = FALSE){
  if (typeof(data) != "list"){
    stop("Argument `data` must be a list")
  }
  
  if (length(data$concentration) == 1){
    warning("Should input more than 1 concentration value.")
  }
  
  if (length(data$absorbance) == 1){
    warning("Should input more than 1 absorbance value.")
  }
  
  if (length(data$concentration) != length(data$absorbance)){
    stop("Each concentration must have a corresponding absorbance")
  }
  
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

typeof(sample_data)


