#' Lomax distribution maximum likelihood estimation
#'
#' Uses Newton-Raphson to estimate the parameters of the Lomax distribution.
#'
#' For the density function of the Lomax distribution see \link[extraDistr]{Lomax}.
#' The maximum likelihood estimate will frequently fail to exist. This is due to
#' the parameterization of the function which does not take into account that
#' the density converges to an exponential along certain values of the parameters,
#' see \code{vignette("Distribution Details", package = "univariateML")}.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param na.rm logical. Should missing values be removed?
#' @param start An optional starting value for the \code{lambda} parameter.
#'    Defaults to \code{median(x)}.
#' @param rel.tol Relative accuracy requested.
#' @param iterlim A positive integer specifying the maximum number of
#' iterations to be performed before the program is terminated.
#'
#' @return \code{mllomax} returns an object of \link[base]{class} \code{univariateML}. This
#'    is a named numeric vector with maximum likelihood estimates for \code{lambda} and \code{kappa} and the following attributes:
#'     \item{\code{model}}{The name of the model.}
#'     \item{\code{density}}{The density associated with the estimates.}
#'     \item{\code{logLik}}{The loglikelihood at the maximum.}
#'     \item{\code{support}}{The support of the density.}
#'     \item{\code{n}}{The number of observations.}
#'     \item{\code{call}}{The call as captured my \code{match.call}}
#' @seealso \link[extraDistr]{Lomax} for the Lomax density.
#' @references Kleiber, Christian; Kotz, Samuel (2003), Statistical Size Distributions in Economics and Actuarial Sciences, Wiley Series in Probability and Statistics, 470, John Wiley & Sons, p. 60
#' @examples set.seed(3)
#'    mllomax(extraDistr::rlomax(100, 2, 4))
#' @export

mllomax = function(x, na.rm = FALSE, start = NULL,
                   rel.tol = .Machine$double.eps^0.25,
                   iterlim = 100) {

  if(na.rm) x = x[!is.na(x)] else assertthat::assert_that(!anyNA(x))
  ml_input_checker(x)
  assertthat::assert_that(min(x) >= 0)

  rel.tol_str = deparse(substitute(rel.tol))
  n = length(x)

  if(is.null(start)) {
    s = mean(x^2)
    m = mean(x)
    alpha = (s - m^2)/(0.5*s - m^2)
    lambda0 = 1/(m*(max(alpha, 1.1) - 1))
  } else {
    lambda0 = start
  }

  for(i in 1:iterlim) {
    S = mean(log(1 + lambda0*x))
    S1 = mean(x/(1 + lambda0*x))
    S2 = -mean(x^2/(1 + lambda0*x)^2)
    top = 1/lambda0 - S1/S - S1
    bottom = -1/lambda0^2 - S2/S + (S1/S)^2 - S2
    lambda = lambda0 - top/bottom

    if(abs((lambda0 - lambda)/lambda0) < rel.tol) break

    if(lambda < 0.00001) {
      stop("The maximum likelihood estimator of the Lomax distribution does not exist. ")
    }

    lambda0 = lambda
  }

  loglik = function(lambda, x) {
      S = mean(log(1 + lambda*x))
      -log(lambda) + log(S) + S + 1
  }

  if(loglik(0.000001, x) < loglik(lambda, x)) {
    stop("The maximum likelihood estimator of the Lomax distribution does not exist. ")
  }

  if(i == iterlim) {
      warning(paste0("The iteration limit (iterlim = ", iterlim, ") was reached",
                     " before the relative tolerance requirement (rel.tol = ",
                     rel.tol_str, ")."))
  }

  S = mean(log(1 + lambda*x))
  object = c(lambda = lambda,
             kappa = 1/mean(log(1 + lambda*x)))
  class(object) = c("univariateML")
  attr(object, "logLik") = n*(log(lambda) - log(S) - S - 1)
  attr(object, "model") = "Lomax"
  attr(object, "density") = "extraDistr::dlomax"
  attr(object, "support") = c(0, Inf)
  attr(object, "n") = length(x)
  attr(object, "call") = match.call()
  object

}

