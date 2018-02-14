---
output:
  md_document:
    variant: markdown_github
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# finddatasetpkgs

*finddatasetpkgs* helps you find other R packages that contain datasets. At the moment, it is pretty stupid, and just looks in the Title field of the DESCRIPTION file of each package on CRAN, and checks if it contains "dataset" or "data set".

## Example

There is one user-facing function, `get_dataset_pkgs()`. Call it without any arguments to get a data frame of packages that probably have datasets in them.

By default, the data will also be shown in a your web browser.


```r
library(finddatasetpkgs)
get_dataset_pkgs()                       # show in browser
```

You can turn this off, if you just want to work with the data frame programmatically.


```r
library(finddatasetpkgs)
pkgs <- get_dataset_pkgs(browse = FALSE) # don't show
knitr::kable(head(pkgs))
```



|    |pkgname                   |description                                                                                  |
|:---|:-------------------------|:--------------------------------------------------------------------------------------------|
|142 |agridat                   |Agricultural Datasets                                                                        |
|233 |AnalyzeFMRI               |Functions for analysis of fMRI datasets stored in the ANALYZE or NIFTI format                |
|293 |aplore3                   |Datasets from Hosmer, Lemeshow and Sturdivant, "Applied Logistic Regression" (3rd Ed., 2013) |
|301 |AppliedPredictiveModeling |Functions and Data Sets for 'Applied Predictive Modeling'                                    |
|305 |aprean3                   |Datasets from Draper and Smith "Applied Regression Analysis" (3rd Ed., 1998)                 |
|328 |archdata                  |Example Datasets from Archaeological Research                                                |

