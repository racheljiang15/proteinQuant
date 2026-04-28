#' Standard Curve Polynomial Regression Fitting
#'
#' @description A function that returns the polynomial regression equations for BCA/ Bradford standard curves.
#' @return Unless stats is set to FALSE, will return a regression equation with protein concentration as y and absorbance as x.
#' @export
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @param stats True or False.
#' @import dplyr
#' @import rlang
#' @examples
#' data(bca_bradford_bsa_standard_curve)
#' sample_data <- bca_bradford_bsa_standard_curve
#' assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance, stats = TRUE)
#'

# added argument `stats`, which is `TRUE` by default. Allows user to choose to not print regression equation by setting stats` to `FALSE`
assay_regression <- function(data, concentration, absorbance, stats = TRUE){
  # warning and error messages
  if (typeof(data) != "list"){
    stop("Argument `data` must be a list")
  }
  
  if (length(data$concentration) == 1){
    warning("Should input more than 1 concentration value.")
  }
  
  if (length(data$absorbance) == 1){
    stop("Should input more than 1 absorbance value.")
  }
  
  if (length(data$concentration) != length(data$absorbance)){
    stop("Each concentration must have a corresponding absorbance")
  }
  
  # data wrangling: added a column of average absorbance based on the absorbance column
  avg_data <- data |>
    dplyr::group_by({{ concentration }}) |>
    dplyr::reframe(avg_absorbance = mean({{ absorbance }})) # calculating average absorbance
  
  # set up the formula to be used inside lm
  #conc <- deparse(substitute(concentration))
  #formula <- as.formula(paste(conc, "~ poly(avg_absorbance, 2)"))
  
  # generate regression equation based on the data set
  #regression <- lm(formula, data = avg_data)
  #regression <- lm({{ concentration }} ~ poly(avg_absorbance, 2), data = avg_data)
  
  conc_name <- rlang::as_name(rlang::ensym(concentration))
  
  formula <- reformulate(
    termlabels = "poly(avg_absorbance, 2)",
    response = conc_name
  )
  
  regression <- lm(formula, data = avg_data)
  coeffs <- coef(summary(regression))
  
  # create the equation printout 
  equation <- paste0(
    conc_name, " = ",
    round(coeffs[1], 4), " + ",
    round(coeffs[2], 4), "x + ",
    round(coeffs[3], 4), "x^2"
  )
  
  # if user selected stats = TRUE, program will enter this if statement and print the equation
  if (stats == TRUE){
    cat("Equation:", equation, "\n\n")
  }
  
  # round coefficients for output
  intercept <- round(coeffs[1], 4)
  primary <- round(coeffs[2], 4)
  secondary<- round(coeffs[3], 4)
  
  # return values as a list to be used in future calculations
  return(invisible(list(intercept = intercept, primary = primary, secondary = secondary, avg_data = avg_data)))
}



