---
title: "Distribution Details"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Distribution Details}
  %\VignetteEngine{knitr::knitr}
  %\VignetteEncoding{UTF-8}
---

This vignette supplies some details about each distribution with maximum 
likelihood estimation implemented in this package. 

## Implemented Distributions

These are the currently implemented distributions. 

| Name                          | Package    | Parameters         | Estimator    | Support        | 
| ----------------------------- | ---------- | ------------------ | ------------ | -------------- | 
| Normal distribution           | stats      | `mean`, `sd`       | `mlnorm`     | $\mathbb{R}$   | 
| Logistic distributon          | stats      | `location`,`scale` | `mllogis`    | $\mathbb{R}$   | 
| Cauchy distributon            | stats      | `location`,`scale` | `mlcauchy`   | $\mathbb{R}$   | 
| Gumbel distribution           | extraDistr | `mu`, `sigma`      | `mlgumbel`   | $\mathbb{R}$   | 
| Laplace distribution          | extraDistr | `mu`, `sigma`      | `mllaplace`  | $\mathbb{R}$   | 
| Exponential distribution      | stats      | `rate`             | `mlexp`      | $[0, \infty)$  | 
| Lomax distribution            | extraDistr | `lambda`, `kappa`  | `mllomax`    | $[0, \infty)$  | 
| Rayleigh distribution         | extraDistr | `sigma`            | `mlrayleigh` | $[0, \infty)$  | 
| Gamma distribution            | stats      | `shape`,`rate`     | `mlgamma`    | $(0, \infty)$  | 
| Weibull distribution          | stats      | `shape`,`scale`    | `mlweibull`  | $(0, \infty)$  |
| Log-normal distribution       | stats      | `meanlog`, `sdlog` | `mllnorm`    | $(0, \infty)$  |
| Inverse gamma distribution    | extraDistr | `alpha`, `beta`    | `mlinvgamma` | $(0, \infty)$  |
| Beta prime distribution       | extraDistr | `shape1`, `shape2` | `mlbetapr`   | $(0, \infty)$  |
| Inverse Gaussian distribution | statmod    | `mean`, `shape`    | `mlinvgauss` | $(0, \infty)$  |
| Beta distibution              | stats      | `shape1`,`shape2`  | `mlbeta`     | $(0, 1)$       |
| Kumaraswamy distribution      | extraDistr | `a`, `b`           | `mlkumar`    | $(0, 1)$       |
| Uniform distribution          | stats      | `min`, `max`       | `mlunif`     | $[\min, \max]$ |
| Power distribution            | extraDistr | `alpha`, `beta`    | `mlpower`    | $[0, a)$       |
| Pareto distribution           | extraDistr | `a`, `b`           | `mlpareto`   | $[b, \infty)$  |

## Comments on the Distributions
### Beta Distribution

The [Beta distribution](https://en.wikipedia.org/wiki/Beta_distribution) is the
most widely distribution on the unit interval. It has a two-dimensional sufficient
satistic and can be calculated very efficiently using `stats::nlm`. The implementation
allows to supply `stats::nlm` with a Hessian or a gradient, but the fastest option is
to provide no information about derivatives to `nlm`.

#### Mathematics
| Name | Value |
| ---- | ----- |
| Parameters | $\alpha$, $\beta$ |
| Likelihood | $\prod_{i=1}^{n}x^{\alpha-1}\left(1-x\right)^{\beta-1}/\textrm{B}\left(\alpha,\beta\right)$ |
| Log-likelihood | $-n\log\left[\textrm{B}\left(\alpha,\beta\right)\right]+\left(\alpha-1\right)\sum_{i=1}^{n}\log\left(x_{i}\right)+\left(\beta-1\right)\sum_{i=1}^{n}\log\left(1-x_{i}\right)$ |
| Analytic solution? | No |