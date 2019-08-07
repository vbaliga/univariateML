
<!-- README.md is generated from README.Rmd. Please edit that file -->

# univariateML <img src="man/figures/logo.png" align="right" width="100" height="70" />

[![Build
Status](https://travis-ci.org/JonasMoss/univariateML.svg?branch=master)](https://travis-ci.org/JonasMoss/univariateML)
[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/JonasMoss/univariateML?branch=master&svg=true)](https://ci.appveyor.com/project/JonasMoss/univariateML)
[![Coverage
Status](https://codecov.io/gh/JonasMoss/univariateML/branch/master/graph/badge.svg)](https://codecov.io/gh/JonasMoss/univariateML?branch=master)
[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

An `R` package for quick and easy maximum likelihood estimation of
univariate densities.

## Overview

This package provided fast and robust maximum likelihood estimation for
a selection of univariate densities. This is work in progress.

## Installation

From inside `R`, use one of the following commands:

``` r
# install.packages("devtools")
devtools::install_github("JonasMoss/univariateML")
```

## Implemented Densities

Maximum likelihood estimation has been implemented for the following
densites. *Note:* Not all of them have been tested, not all of includes
a `logLik` attribute, and they do not adhere to a common interface
yet.

| Name                       | Package    | Parameters                  | Density     | Support      |
| -------------------------- | ---------- | --------------------------- | ----------- | ------------ |
| Normal distribution        | stats      | `mean`, `sd`                | `dnorm`     | R            |
| Exponential distribution   | stats      | `rate`                      | `dexp`      | \[0, ∞)      |
| Beta distibution           | stats      | `shape1`,`shape2`           | `dbeta`     | (0, 1)       |
| Gamma distribution         | stats      | `shape`,`rate`              | `dgamma`    | (0, ∞)       |
| Weibull distribution       | stats      | `shape`,`scale`             | `dweibull`  | (0, ∞)       |
| Log-normal distribution    | stats      | `meanlog`, `sdlog`          | `dlnorm`    | (0, ∞)       |
| Logistic distributon       | stats      | `location`,`scale`          | `dlogis`    | R            |
| Cauchy distributon         | stats      | `location`,`scale`          | `dcauchy`   | R            |
| Uniform distribution       | stats      | `min`, `max`                | `dunif`     | \[min, max\] |
| Gumbel distribution        | extraDistr | `mu`, `sigma`               | `dgumbel`   | R            |
| Kumaraswamy distribution   | extraDistr | `a`, `b`                    | `dkumar`    | (0, 1)       |
| Beta prime distribution    | extraDistr | `shape1`, `shape2`, `scale` | `dbetapr`   | (0, ∞)       |
| Wald distribution          | extraDistr | `mu`, `lambda`              | `dwald`     | (0, ∞)       |
| Laplace distribution       | extraDistr | `mu`, `sigma`               | `dlaplace`  | R            |
| Rayleigh distribution      | extraDistr | `sigma`                     | `drayleigh` | \[0, ∞)      |
| Pareto distribution        | extraDistr | `a`, `b`                    | `dpareto`   | \[b, ∞)      |
| Power distribution         | extraDistr | `alpha`, `beta`             | `dpower`    | \[0, a)      |
| Lomax distribution         | extraDistr | `lambda`, `kappa`           | `dlomax`    | \[0, ∞)      |
| Inverse gamma distribution | extraDistr | `alpha`, `beta`             | `dinvgamma` | (0, ∞)       |