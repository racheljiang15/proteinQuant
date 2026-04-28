#' Standard Curve Linear Regression Fitting
#'
#' @description A function that returns the linear regression equations for UV 280 standard curves.
#' @return A regression equation with protein concentration as y and absorbance as x.
#' @export
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @param stats True or False.
#' @import dplyr
#' @import rlang
#' @examples
#' data(UV_bsa_standard_curve)
#' sample_data <- UV_bsa_standard_curve
#' UV280_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Absorbance, stats = TRUE)
#'

# added argument `stats`, which is `FALSE` by default. Allows user to choose to see additional statistics by setting stats` to `TRUE`
UV280_regression <- function(data, concentration, absorbance, stats = FALSE){
  # warning and error messages
  #if (typeof(data) != "list"){
    #stop("Argument `data` must be a list")
  #}
  if (!is.list(data)) {
    stop("Argument `data` must be a list")
  }
  
  data <- as.data.frame(data)
  
  if (length(data$concentration) == 1){
    warning("Should input more than 1 concentration value.")
  }
  
  if (length(data$absorbance) == 1){
    warning("Should input more than 1 absorbance value.")
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
  
  # generate regression equation based on the data set
  #regression <- lm(as.formula(paste("avg_absorbance ~", conc)), data = avg_data)
  #regression <- lm(avg_absorbance ~ {{ concentration }},data = avg_data)
  conc_name <- rlang::as_name(rlang::ensym(concentration))
  
  formula <- reformulate(
    termlabels = conc_name,
    response = "avg_absorbance"
  )
  
  regression <- lm(formula, data = avg_data)
  coeffs <- coef(summary(regression))
  
  # create the equation printout 
  equation <- paste0(
    "avg_absorbance = ",
    round(coeffs[1], 4), " + ",
    round(coeffs[2], 4), "x"
  )
  
  # printing equation
  cat("Equation:", equation, "\n\n")
  
  # if user selected stats = TRUE, program will enter this if statement
  if (stats == TRUE){
    print(coeffs)
  }
  
  # round coefficients for output
  intercept <- round(coeffs[1], 4)
  primary <- round(coeffs[2], 4)
  secondary<- NA
  
  # return values as a list to be used in future calculations
  return(list(intercept = intercept, primary = primary, secondary = secondary, avg_data = avg_data))
}






