#' Standard Curve Graphing for UV280
#'
#' @description A function that returns a graph of the Beer's Law equation for UV280 standard curves. 
#' @return A plot showing the data points of the standard curve, as well as the fitted Beer's Law equation.
#' @export
#' @import ggplot2
#' @examples
#' \dontrun{
#' sample_bradf <- assayConc(data = bradford_sample_data, absorbance = Absorbance, regression = sample_bradf_regression)
#' assayGraph(data = sample_bradf, absorbance = Absorbance, concentration = Concentration)
#' }
#'

assayGraph <- function(data, absorbance, concentration){
  library(ggplot2)
  
  ggplot(data = data,
         aes(x = {{absorbance}},
             y = {{concentration}})) +
    geom_point() +
    theme_bw() +
    labs(x = "Absorbance",
         y = "Concentration (ug/mL)")
}








# make regression, returned as a list
#sample_bradf_regression <- assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
# calculate concentration, returned as a list with absorbance and concentration
#sample_bradf <- assayConc(data = bradford_sample, absorbance = Absorbance, regression = sample_bradf_regression)

# testing assayGraph
#assayGraph(data = sample_bradf, absorbance = Absorbance, concentration = Concentration)



