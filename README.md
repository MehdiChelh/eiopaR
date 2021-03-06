
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eiopaR

<!-- badges: start -->

[![Lifecycle:
maturing](https://img.shields.io/badge/lifecycle-maturing-blue.svg)](https://lifecycle.r-lib.org/articles/stages.html#maturing)
[![R-CMD-check](https://github.com/MehdiChelh/eiopaR/actions/workflows/check-standard.yaml/badge.svg)](https://github.com/MehdiChelh/eiopaR/actions/workflows/check-standard.yaml)
[![](https://www.r-pkg.org/badges/version/eiopaR?color=green)](https://cran.r-project.org/package=eiopaR)
<!-- badges: end -->

A simple package to get the EIOPA rates directly in your script.

The data is accessed through an API which is regularly updated with the
latest EIOPA rates.

**Note:**

-   This package requires an internet connection in order to access the
    risk-free rates data.
-   The API or the [author](mailto:mehdi.echel@gmail.com) of this
    package are not related to EIOPA.

## Installation

You can install the released version of eiopaR from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("eiopaR")
```

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("MehdiChelh/eiopaR")
```

**Note:** If you use Excel, you can also use the add-in
[EIOPA\_API.xlam](https://github.com/MehdiChelh/eiopaR/raw/master/EIOPA_API.xlam)
of this repository (in the Excel ribbon:
`Developer > Add-ins > Browse > EIOPA_API.xlam`). It imports a formula
called `EIOPA` that can be used in Excel as follows:
`EIOPA("with_va", "FR", 2019, 12)` or also
`EIOPA("no_va", "FR", 2019, 12)`.

## Example

The following script gives you the risk-free rates with volatility
adjustment:

``` r
library(eiopaR)

rfr <- get_rfr_with_va(region = "FR", year = 2017:2018, month = 12)
rfr
#> <eiopa_rfr>
#> 20171231_rfr_spot_with_va_FR > -0.00318, -0.0021, -0.00048 ...
#> 20181231_rfr_spot_with_va_FR > -0.00093, -0.00035, 0.00063 ...
```

**Note:** It is recommended to **limit the number of calls** to the
functions `get_rfr`, `get_rfr_with_va`, `get_rfr_no_va` and to store the
results of your calls in the environment variables of your session (like
in the example above `rfr <- get_...`). Your IP can be temporary or
permanently blocked if too many queries are executed.

The rates are then accessible as a `data.frame`:

``` r
head(rfr$data)
#>   20171231_rfr_spot_with_va_FR 20181231_rfr_spot_with_va_FR
#> 1                     -0.00318                     -0.00093
#> 2                     -0.00210                     -0.00035
#> 3                     -0.00048                      0.00063
#> 4                      0.00109                      0.00194
#> 5                      0.00249                      0.00339
#> 6                      0.00387                      0.00478
```

``` r
plot(
  rfr$data$`20171231_rfr_spot_with_va_FR`,
  ylab = "2017-12",
  type = 'l',
  col = "purple"
)
```

<img src="man/figures/README-plot_data-1.png" width="65%" style="display: block; margin: auto;" />

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Credit

See [EIOPA \| Risk-free interest rate term
structures](https://www.eiopa.europa.eu/tools-and-data/risk-free-interest-rate-term-structures_en)
for more information.

## License

[MIT](https://choosealicense.com/licenses/mit/)
