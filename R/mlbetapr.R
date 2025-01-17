#' Beta prime distribution maximum likelihood estimation
#'
#' This function does not estimate the scale parameter for the \code{BetaPrime}
#'     distribution. Transforms the data and uses \code{stat::nlm} to estimate
#'     the parameters of the Beta distribution.
#'
#' For the density function of the Beta prime distribution see \link[extraDistr]{BetaPrime}.
#'
#' @param x a (non-empty) numeric vector of data values.
#' @param na.rm logical. Should missing values be removed?
#' @param start Optional starting parameter values for the minimization.
#' Passed to the \code{stats::nlm} function.
#' @param type Whether a dedicated \code{gradient} or \code{hessian} should be
#' passed to \code{stats::nlm}.
#' @return \code{mlbetapr} returns an object of \link[base]{class} \code{univariateML}. This
#'    is a named numeric vector with maximum likelihood estimates for \code{shape1} and \code{shape2} and the following attributes:
#'     \item{\code{model}}{The name of the model.}
#'     \item{\code{density}}{The density associated with the estimates.}
#'     \item{\code{logLik}}{The loglikelihood at the maximum.}
#'     \item{\code{support}}{The support of the density.}
#'     \item{\code{n}}{The number of observations.}
#'     \item{\code{call}}{The call as captured my \code{match.call}}
#' @details For \code{type}, the option \code{none} is fastest.
#' @seealso \link[extraDistr]{BetaPrime} for the Beta prime density, \link[stats]{nlm} for the
#'   optimizer this function uses, \link{mlbeta} for the Beta distribution maximum
#'   likelihood estimator.
#' @examples AIC(mlbetapr(USArrests$Rape))
#' @references Johnson, N. L., Kotz, S. and Balakrishnan, N. (1995) Continuous Univariate Distributions, Volume 2, Chapter 25. Wiley, New York.
#' @export

mlbetapr = function(x, na.rm = FALSE, start = NULL,
                    type = c("none", "gradient", "hessian")) {

  if(na.rm) x = x[!is.na(x)] else assertthat::assert_that(!anyNA(x))
  ml_input_checker(x)
  assertthat::assert_that(min(x) > 0)

  val1 = mean(log(x))
  val2 = mean(log(1 + x))
  object = mlbeta(x/(x + 1), na.rm = FALSE, start, type)
  alpha = object[1]
  beta = object[2]
  class(object) = "univariateML"
  attr(object, "model") = "BetaPrime"
  attr(object, "density") = "extraDistr::dbetapr"
  attr(object, "logLik") = unname(-length(x)*(lbeta(alpha, beta) -
                                                (alpha - 1)*val1 +
                                                (alpha + beta)*val2))
  attr(object, "support") = c(0, Inf)
  attr(object, "n") = length(x)
  attr(object, "call") = match.call()
  object


}
