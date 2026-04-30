utils::globalVariables(c("avg_absorbance"))

#' Standard Curve Graphing for BCA and Bradford Assays
#'
#' @description A function that returns a graph of the polynomial regression fitting for BCA and Bradford standard curves. 
#' @return A plot showing the data points of the standard curve, as well as the fitted polynomial regression model.
#' @export
#' @import ggplot2
#' @import dplyr
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @examples
#' data(bca_bradford_bsa_standard_curve)
#' sample_data <- bca_bradford_bsa_standard_curve
#' assay_graphing_tool(sample_data, Concentration.ug.mL., Bradford_Absorbance)
#'

# graphing tool for graphing standard curve
assay_graphing_tool <- function(data, concentration, absorbance) {
  # warning and error messages
  if (!is.list(data)) {
    stop("Argument `data` must be a list")
  }
  
  data <- as.data.frame(data)
  
  if (length(data$concentration) == 1){
    warning("Input should include more than 1 concentration value.")
  }
  
  if (length(data$absorbance) == 1){
    warning("Input should include more than 1 absorbance value.")
  }
  
  if (length(data$concentration) != length(data$absorbance)){
    stop("Each concentration must have a corresponding absorbance")
  }
  
  # data wrangling: added a column of average absorbance based on the absorbance column 
  avg_data <- data |>
    dplyr::group_by({{ concentration }}) |>
    dplyr::reframe(avg_absorbance = mean({{ absorbance }})) # calculating average absorbance
  
  # use ggplot to generate a graph for the standard curve
  ggplot2::ggplot(data = avg_data,
         ggplot2::aes(x = avg_absorbance,
             y = {{ concentration }})) +
    ggplot2::geom_point() + # adds data point from the data set
    ggplot2::geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) + # generate polynomial regression line
    ggplot2::theme_bw() +
    ggplot2::labs(x = "Average Absorbance",
         y = "Concentration (ug/mL)") # change axis titles
}
