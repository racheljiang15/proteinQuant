#' Full Protein Quantification Analysis
#'
#' @description A function that returns fitted standard curve regression models and calculated concentrations, given standard curve and experimental absorbance data for BCA and Bradford Assays. 
#' @return A plot showing the data points of the standard curve, the fitted polynomial regression model of that standard curve, and the concentrations of experimental samples.
#' @export
#' @import ggplot2
#' @import dplyr
#' @import rlang
#' @param assay Name of assay performed as a string: BCA, Bradford, or UV 280
#' @param stdcurve List containing  absorbance and concentration values obtained in creation of a standard curve.
#' @param stdconc Name of column containing concentration values in stdcurve.
#' @param stdabs Name of column containing absorbance.
#' @param data Dataframe containing absorbance and concentration values.
#' @param concentration Name of column containing concentration values in data.
#' @param absorbance Name of column containing absorbance values in data.
#' @param stats True or False.
#' @param printWell True or False.
#' @examples
#' assayAnalysis(assay = "Bradford",
#' stdcurve = bca_bradford_bsa_standard_curve,
#' stdconc = Concentration.ug.mL.,
#' stdabs = Bradford_Absorbance,
#' data = bradford_sample_data, 
#' absorbance = Absorbance, 
#' stats = TRUE)
#' 

assayAnalysis <- function(assay, stdcurve, stdconc, stdabs, data, concentration = NULL, absorbance, stats = FALSE, printWell = TRUE){
  # set input for argument assay into lower case useful for setting up if statements
  assay <- tolower(assay)
  
  #checking if assay is one of the specified ones we can analyze with our package
  if (!assay %in% c("bca", "bradford", "uv280")){
    stop("assay must be one of the following: BCA, Bradford, or UV280")
  }
  
  # check if the input dataset for the stdcurve and data arguments is in the appropriate format
  if (typeof(stdcurve) != "list"){
    stop("Input data for stdcurve must be a list")
  }

  if (!is.list(data)) {
    stop("Input data for data argument must be a list.")
  }
  data <- as.data.frame(data)
  
  # check if the input data for conc and absorbance used in standard curve calculations are in appropriate lengths
  if (length(stdcurve$stdconc)==1){
    stop("Should input more than 1 concentration value for standard curve.")
  }
  if (length(stdcurve$stdabs)==1){
    stop("Should input more than 1 absorbance value for standard curve.")
  }

  #for when user selects BCA or Bradford as their assay type
  if (assay %in% c("bca", "bradford")){
    #getting regression
    regression <- assay_regression(
      data = stdcurve,
      concentration = {{stdconc}},
      absorbance = {{stdabs}},
      stats = stats)
    
    #getting concentrations
    results <- assayConc(
      data = data,
      absorbance = {{absorbance}},
      regression = regression,
      printWell = printWell
    )
    
    #plotting standard curve
    plot <- assay_graphing_tool(
      data = stdcurve,
      concentration = {{stdconc}},
      absorbance = {{stdabs}}
    )
    print(plot)
  }
  
  #for when user selects UV280 as their assay type
  if (assay == "uv280") {
    #getting regression
    regression <- UV280_regression(
      data = stdcurve,
      concentration = {{stdconc}},
      absorbance = {{stdabs}},
      stats = stats
    )
    
    #getting concentrations
    results <- assayConc(
      data = data,
      absorbance = {{absorbance}},
      regression = regression,
      printWell = printWell
    )
    
    #plotting standard curve
    plot <- UV_graphing_tool(
      data = stdcurve,
      concentration = {{stdconc}},
      absorbance = {{stdabs}}
    )
    print(plot)
  }

  #FINAL OUTPUT
  return(invisible(list(
    assay = assay,
    regression = regression,
    results = results,
    plot = plot
  )))
}


