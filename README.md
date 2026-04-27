# ProteinQuant

Protein quantification is the determination of a solution’s protein concentration and is a crucial step in many biochemical studies. For example, in the development of cancer treatments, knowing protein concentration is often required to evaluate the therapeutic effects of antibody drug conjugates and other engineered proteins. Several assays currently exist for the experimental determination of this concentration, including the Bradford & BCA assays and intrinsic UV absorbance at 280 nm (A280). Despite their widespread usage, each method requires extensive calculation.

To address this challenge, this package aims to create tools that enable efficient assay data analysis and visualization. Use of this package will accelerate the protein quantification process, with applications in both academic research labs and large-scale pharmaceutical development.

Functions in this package and their primary usage are listed below: 

1. `assay_regression`: Fits a polynomial regression model for BCA and Bradford Assay standard curves with protein concentration as the response variable and absorbance as the explanatory.

2. `assayConc`: Calculates the concentrations of unknown samples for all three quantification methods, given a standard curve's fitted regression equation.

3. `assay_graphing_tool`: Graphs the standard curve of a BCA or Bradford Assay standard curve. 

4. `UV280_regression`: Fits a linear regression model for UV280 standard curves with absorbance as the response variable and concentration is the explanatory variable.

5. `UV_graphing_tool`: Graphs the standard curve of a UV280 standard curve.

6. `assayAnalysis`: Wrapper function that provides complete analysis by fitting the appropriate regression model, graphing it, and calculating the concentrations of unknown samples. 

Sample data sets included in the package: 

1. `bca_bradford_bsa_standard_curve`

2. `bradford_sample_data`

3. `UV_sample_data`

4. `standard_curve_UV280`

5. `BCA_sample_data`


## Installation

You can install `proteinQuant` from GitHub with 

```{r}
# install.packages("pak")
pak::pak("racheljiang15/proteinQuant")
```


## Example

Below is an example of using the `assayAnalysis` function to perform complete analysis of sample Bradford Assay datasets.

```{r setup}
library(proteinQuant)
```
```{r}
assayAnalysis(assay = "Bradford",
  stdcurve = bca_bradford_bsa_standard_curve,
  stdconc = Concentration.ug.mL.,
  stdabs = Bradford_Absorbance,
  data = bradford_sample_data,
  absorbance = Absorbance,
  stats = TRUE)
```







