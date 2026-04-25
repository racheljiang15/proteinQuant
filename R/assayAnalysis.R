#' Full Analysis of Raw BCA/ Bradford Assay Data
#'
#' @description A function that returns fitted standard curve regression models and calculated concentrations, given standard curve and experimental absorbance data for BCA and Bradford Assays. 
#' @return A plot showing the data points of the standard curve, the fitted polynomial regression model of that standard curve, and the concentrations of experimental samples.
#' @export
#' @import ggplot2
#' @import dplyr
#' @param assay Name of assay performed: BCA, Bradford, or UV 280
#' @param stdcurve List containing  absorbance and concentration values obtained in creation of a standard curve.
#' @param stdconc Name of column contianing concentration values in stdcurve.
#' @param stdabs Name of column containing absorbance.
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @param stats True or False.
#' @param printWell True or False.
#' @examples
#'

assayAnalysis <- function(assay, stdcurve, stdconc, stdabs, data, concentration, absorbance, stats, printWell){
  
}