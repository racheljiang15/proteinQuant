#' Standard Curve Graphing for UV280
#'
#' @description A function that returns a graph of the Beer's Law equation for UV280 standard curves. 
#' @return A plot showing the data points of the standard curve, as well as the fitted Beer's Law equation.
#' @export
#' @import ggplot2
#' @param data Dataframe containing absorbance and concentration values.
#' @param absorbance Name of column containing absorbance values in data.
#' @param concentration Name of column containing concentration values in data.
#' @examples
#' \dontrun{
#' sample_bradf <- assayConc(data = bradford_sample_data, absorbance = Absorbance, regression = sample_bradf_regression)
#' assayGraph(data = sample_bradf, absorbance = Absorbance, concentration = Concentration)
#' }
#'

assayGraph <- function(data, absorbance, concentration){
  # add warning and error messages
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
  
  # use ggplot to generate a graph for the standard curve
  ggplot(data = data,
         aes(x = {{absorbance}},
             y = {{concentration}})) +
    geom_point() +
    theme_bw() +
    labs(x = "Absorbance",
         y = "Concentration (ug/mL)") # change axis titles
}








# make regression, returned as a list
#sample_bradf_regression <- assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
# calculate concentration, returned as a list with absorbance and concentration
#sample_bradf <- assayConc(data = bradford_sample, absorbance = Absorbance, regression = sample_bradf_regression)

# testing assayGraph
#assayGraph(data = sample_bradf, absorbance = Absorbance, concentration = Concentration)



