#' Standard Curve Graphing
#'
#' @description A function that returns a graph of the polynomial regression fitting for BCA and Bradford standard curves. 
#' @return A plot showing the data points of the standard curve, as well as the fitted polynomial regression model.
#' @export
#' @import tidyverse
#' @examples
#' sample_data <- bca_bradford_bsa_standard_curve
#' graphing_tool(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
#'

# graphing tool for graphing standard curve
graphing_tool <- function(data, concentration, absorbance) {
  library(tidyverse)
  
  avg_data <- data |>
    group_by({{ concentration }}) |>
    reframe(avg_absorbance = mean({{ absorbance }}))
  
  ggplot(data = avg_data,
         aes(x = avg_absorbance,
             y = {{ concentration }})) +
    geom_point() +
    geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE) +
    theme_bw() +
    labs(x = "Average Absorbance",
         y = "Concentration (ug/mL)")
}

#sample_data <- bca_bradford_bsa_standard_curve
#graphing_tool(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
