
# qr.live

<!-- badges: start -->
<!-- badges: end -->

I wanted to easily create a SVG QR code, which was not easily possible with other open tools. This was a nice case for a shinylive app.

I drew some inspiration from the [minimal working example here](https://stackoverflow.com/a/70577693).

## Wish list

- [x] Output SVG format

- [ ] Options for ecl (value set to M for now)

- [ ] Create Wifi credentials (see [qifi](https://github.com/evgeni/qifi))

- [ ] Choose output format

- [ ] Edit [colors in app](https://github.com/Broccolito/QR_Code_Generator)

## Installation an example use

To use the package and run the shiny-app locally, you can install the development version of qr.live with:

``` r
# install.packages("devtools")
devtools::install_github("agdamsbo/qr.live")
```

Launch the included shiny app with the following code:

``` r
library(qr.live)
shiny_qr()
```

## Code of Conduct

Please note that the cognitive.index.lookup project is released with a [Contributor Code of Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html). By contributing to this project, you agree to abide by its terms.
