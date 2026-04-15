## ProteinQuant

Protein quantification is the determination of a solution’s protein concentration and is a crucial step in many biochemical studies. For example, in the development of cancer treatments, knowing protein concentration is often required to evaluate the therapeutic effects of antibody drug conjugates and other engineered proteins. Several assays currently exist for the experimental determination of this concentration, including the Bradford & BCA assays and intrinsic UV absorbance at 280 nm (A280). Despite their widespread usage, each method requires extensive calculation. 

To address this challenge, this package aims to create tools that enable efficient assay data analysis and visualization. A function is included to facilitate assay preparation, calculating volumes used in dilution series for Bradford, BCA, and A280 methods. Raw data from a plate reader will be input by the user as a CSV file. Other data analysis functions will be used to process the raw data, generate standard curves, and fit and visualize the appropriate linear or polynomial regression lines. Curve fitting for the A280 method will be based on Beer’s Law equation (absorbance = molar absorptivity * path length * concentration OR $A = \epsilon c l$). An additional function will be used to calculate protein concentration estimates from the regression models. Final functions will be included to assist post-assay work, tracking how much protein has been used in the assay, and the remaining amounts based on user input of total starting volume. Use of this package will accelerate the protein quantification process with applications in both academic research labs and large-scale pharmaceutical development. 


Functions in this package are listed below: 

1. `assay_regression`

2. `graphing_tool`

3. `assayConc`

4. `assayGraph`


Sample data sets included in the package: 

1. **bca_bradford_bsa_standard_curve**

2. **bca_bradford_standard_curve_data**

3. **bradford_sample_data**

4. **UV_bsa_standard_curve**



## Installation

You can install `proteinQuant` from GitHub with 

```{r}
#| eval: true
#| echo: true
#| message: false
#| warning: false

# install.packages("pak")
pak::pak("racheljiang15/proteinQuant")
```


## Example

Below is an example setup of using the `assay_regression` function to generate a regression line for the inputted data set. 

```{r}
#| eval: true
#| echo: true
#| message: false
#| warning: false

# import package
library(proteinQuant)

# run function
assay_regression(data = bca_bradford_bsa_standard_curve, concentration = Concentration.ug.mL., absorbance = Bradford_Absorbance, stats = TRUE)
```




::: {.callout-important}
**Below is subject to change**

All core information regarding the package, including the package name, author information, GitHub link, licensing, and imported functions, will be stored in the `DESCRIPTION` file. Exported and imported functions will be kept in `NAMESPACE`. Each function will be coded in a separate `R` file, and all `R` files will be stored in the `R` folder. Since information from each step in the protein quantification process is carried to future steps, dependencies between the R files will be established. Concentrations from the dilution series function will be passed to the standard curves and regression modeling functions. Visualization functions will incorporate results from regression functions. The fitted regression models will be passed to the protein concentration function. Lastly, the protein tracking function will be able to access results from all prior functions. Manuals will be stored in the `man` folder, and tests will be stored in the `tests` folder. 
:::







