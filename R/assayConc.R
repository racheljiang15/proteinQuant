#' Concentrations for Unknown Protein Samples
#'
#' @description A function that returns the concentrations of unknown protein samples, based on absorbance data.
#' @return A data frame with the concentrations of each sample.
#' @export
#' @param data *add description
#' @examples
#' sample_bradf_regression <- assay_regression(data = bca_bradford_bsa_standard_curve, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
#' assayConc(data = bradford_sample_data, absorbance = Absorbance, regression = sample_bradf_regression)
#'

# returns a list with the calculated concentrations
assayConc <- function(data, absorbance, regression, printWell = TRUE) {
  # warning and error messages
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
  
  # data wrangling for list creationg
  abs_values <- data |> pull({{ absorbance }})
  # create empty list to store calculated concentrations
  conc <- vector("numeric", length(abs_values))
  
  # go through all absorbance values and calculate corresponding concentration, then store the value to the conc list
  for (i in seq_along(abs_values)){
    conc[[i]] <- regression$intercept + regression$primary * abs_values[i] + regression$secondary * abs_values[i]^2
  }
  
  # concatenate the calculated concentration values with the original absorbance values
  result <- data |> mutate(Concentration = conc)
  
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

# create sample data for testing
#sample_data <- bca_bradford_bsa_standard_curve
#bradford_sample <- bradford_sample_data

# make regression, returned as a list
#sample_bradf_regression <- assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)

# test function NOTE: add units
#assayConc(data = bradford_sample, absorbance = Absorbance, regression = sample_bradf_regression)






