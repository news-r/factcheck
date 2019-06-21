#' Setup
#' 
#' Setup your session, all subsequent calls will be done using the API key.
#'
#' @param key Your API key, freely available at \url{https://console.cloud.google.com}.
#' 
#' @note You can specify \code{FACTCHECK_API_KEY} as environment variable, likely in your \code{.Renviron} file.
#' 
#' @import httr
#' @import assertthat
#' 
#' @export
factcheck_key <- function(key) {
  assert_that(!missing(key), msg = "Missing key")
  Sys.setenv("FACTCHECK_API_KEY" = key)
}
