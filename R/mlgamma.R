#' Gamma distribution maximum likelihood estimation
#'
#' Uses Newton-Raphson to estimate the parameters of the Gamma distribution.
#'
#' For the density function of the Gamma distribution see \link[stats]{GammaDist}.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param na.rm logical. Should missing values be removed?
#' @param rel.tol Relative accuracy requested.
#' @param iterlim A positive integer specifying the maximum number of
#' iterations to be performed before the program is terminated.
#' @return \code{mlgamma} returns an object of \link[base]{class} \code{univariateML}. This
#'    is a named numeric vector with maximum likelihood estimates for \code{shape} and \code{rate} and the following attributes:
#'     \item{\code{model}}{The name of the model.}
#'     \item{\code{density}}{The density associated with the estimates.}
#'     \item{\code{logLik}}{The loglikelihood at the maximum.}
#'     \item{\code{support}}{The support of the density.}
#'     \item{\code{n}}{The number of observations.}
#'     \item{\code{call}}{The call as captured my \code{match.call}}
#' @examples mlgamma(precip)
#' @seealso \link[stats]{GammaDist} for the Gamma density.
#' @references Choi, S. C, and R. Wette. "Maximum likelihood estimation of the parameters of the gamma distribution and their bias." Technometrics 11.4 (1969): 683-690.
#' Johnson, N. L., Kotz, S. and Balakrishnan, N. (1995) Continuous Univariate Distributions, Volume 1, Chapter 17. Wiley, New York.
#' @export

mlgamma = function(x,  na.rm = FALSE, rel.tol = .Machine$double.eps^0.25,
                   iterlim = 100) {

  if(na.rm) x = x[!is.na(x)] else assertthat::assert_that(!anyNA(x))
  ml_input_checker(x)
  assertthat::assert_that(min(x) > 0)

  rel.tol_str = deparse(substitute(rel.tol))

  n = length(x)
  mean_hat = mean(x)
  L = mean(log(x))
  s = log(mean_hat) - L

  ## This start estimator is very close to the ML estimator already.
  shape0 = 1/(12*s)*(3 - s + sqrt((s-3)^2 + 24*s))

  ## The Newton-Raphson steps.
  for(i in 1:iterlim) {
    shape = shape0 - (1/(1/shape0 - trigamma(shape0))*(log(shape0) - digamma(shape0) - s))
    if(abs((shape - shape0)/shape0) < rel.tol) break
    shape0 = shape
  }

  if(i == iterlim) {
    warning(paste0("The iteration limit (iterlim = ", iterlim, ") was reached",
                   " before the relative tolerance requirement (rel.tol = ",
                   rel.tol_str, ")."))
  }

  ## Given the shape, the rate is easy to compute.
  rate = shape/mean_hat

  object = c(shape = shape, rate = rate)
  class(object) = "univariateML"
  attr(object, "model") = "Gamma"
  attr(object, "density") = "stats::dgamma"
  attr(object, "logLik") = n*(shape*log(rate) - log(gamma(shape)) +
                                (shape - 1)*L - rate*mean_hat)
  attr(object, "support") = c(0, Inf)
  attr(object, "n") = length(x)
  attr(object, "call") = match.call()
  object
}
