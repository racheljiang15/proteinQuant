# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'


bca_bradford_bsa_standard_curve <- read.csv("bca_bradford_bsa_standard_curve.csv")
usethis::use_data(bca_bradford_bsa_standard_curve, overwrite = TRUE)


# sample_plate_reader <- usethis::use_data(x)











