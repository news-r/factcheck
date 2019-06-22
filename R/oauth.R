#' OAuth
#' 
#' Create an OAuth token.
#' 
#' @param key,secret Your key and secret from a Google Console app: \url{https://console.cloud.google.com}.
#' @param app_name 
#' 
#' @export
fact_token <- function(cache = gargle::gargle_oauth_cache(), 
  use_oob = gargle::gargle_oob_default()) {

  token <- gargle::token_fetch(
    cache = cache,
    use_oob = use_oob,
    scopes = "https://www.googleapis.com/auth/userinfo.email"
  )
  options(FACTCHECK_TOKEN = token)
  invisible(token)
}