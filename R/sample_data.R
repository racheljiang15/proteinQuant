#' Protein Quantification Tests BCA Bradford and UV280
#'
#' @description The data was collected in an introductory Biochemistry lab course at Smith College in the Spring 2026 semester. It includes absorbance data used in the creation of BSA standard curves for three protein quantification methods: BCA assay, Bradford assay, and UV280. It also provides method-specific data of absorbance values across 7 test proteins.
#' @format Data frames with concentration and absorbance values
#' @export 
#' @source R. Jiang and A.Y. Cheng (2026), BCH 253-01 Smith College
#' @examples
#' sample_data <- bca_bradford_bsa_standard_curve
#' assay_regression(data = sample_data,
#'                  concentration = Concentration.ug.mL.,
#'                  absorbance = Bradford_Absorbance,
#'                  stats = TRUE)
#'
#' @name sample_data
NULL

bca_bradford_bsa_standard_curve
#bca_bradford_bsa_standard_curve <- read.csv("bca_bradford_bsa_standard_curve.csv")
#usethis::use_data(bca_bradford_bsa_standard_curve, overwrite = TRUE)
bradford_sample_data
#bradford_sample_data <- read.csv("bradford_sample_data.csv")
#usethis::use_data(bradford_sample_data, overwrite = TRUE)
UV_bsa_standard_curve
#UV_bsa_standard_curve <- read.csv("UV_bsa_standard_curve.csv")
#usethis::use_data(UV_bsa_standard_curve, overwrite = TRUE)