
# returns a list with the calculated concentrations
assayConc <- function(data, absorbance, regression, printWell = TRUE) {
  abs_values <- data |> pull({{ absorbance }})
  conc <- vector("numeric", length(abs_values))
  
  for (i in seq_along(abs_values)){
    conc[[i]] <- regression$intercept + regression$primary * abs_values[i] + regression$secondary * abs_values[i]^2
  }
  
  result <- data |> mutate(Concentration = conc)
  
  if (printWell == TRUE){
    print(knitr::kable(result))
    return(invisible(as.data.frame(result)))
  }
  
  else{
    return(as.data.frame(result))
  }
  
}

# create sample data for testing
sample_data <- bca_bradford_bsa_standard_curve
bradford_sample <- bradford_sample_data

# make regression, returned as a list
sample_bradf_regression <- assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)

# test function NOTE: add units
assayConc(data = bradford_sample, absorbance = Absorbance, regression = sample_bradf_regression)






