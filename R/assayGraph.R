assayGraph <- function(data, absorbance, concentration){
  library(tidyverse)
  
  ggplot(data = data,
         aes(x = {{absorbance}},
             y = {{concentration}})) +
    geom_point() +
    theme_bw() +
    labs(x = "Absorbance",
         y = "Concentration (ug/mL)")
}








# make regression, returned as a list
sample_bradf_regression <- assay_regression(data = sample_data, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance)
# calculate concentration, returned as a list with absorbance and concentration
sample_bradf <- assayConc(data = bradford_sample, absorbance = Absorbance, regression = sample_bradf_regression)

# testing assayGraph
assayGraph(data = sample_bradf, absorbance = Absorbance, concentration = Concentration)



