#' Concentrations Calculator
#'
#' @description A function that returns the concentrations of unknown protein samples, based on absorbance data, as a data frame.
#' @return A data frame with the concentrations of each sample.
#' @export
#' @param data List containing absorbance values.
#' @param absorbance Name of column containing absorbance values in data.
#' @param regression List of regression modeling coefficients.
#' @param printWell True or False.
#' @examples
#' sample_bradf_regression <- assay_regression(bca_bradford_bsa_standard_curve, 
#' Concentration.ug.mL., 
#' Bradford_Absorbance)
#' assayConc(bradford_sample_data, Absorbance, sample_bradf_regression)
#'

# returns a list with the calculated concentrations
assayConc <- function(data, absorbance, regression, printWell = TRUE) {
  # warning and error messages
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
  
  # data wrangling for list creationg
  abs_values <- data |> dplyr::pull({{ absorbance }})
  # create empty list to store calculated concentrations
  conc <- vector("numeric", length(abs_values))
  
  # go through all absorbance values and calculate corresponding concentration, then store the value to the conc list
  for (i in seq_along(abs_values)){
    conc[[i]] <- regression$intercept + regression$primary * abs_values[i] + ifelse(is.na(regression$secondary), 0, regression$secondary * abs_values[i]^2)
  }
  
  # concatenate the calculated concentration values with the original absorbance values
  result <- data |> dplyr::mutate(Concentration = conc)
  
  # if user chose printWell, will print in the kable format
  if (printWell == TRUE){
    print(knitr::kable(result))
    return(invisible(as.data.frame(result)))
  }
  
  # if user selected default format, will print normally
  else{
    return(as.data.frame(result))
  }
  
}






