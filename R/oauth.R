#' OAuth
#' 
#' Create an OAuth token.
#' 
#' @param cache Whether to cache the token.
#' @param use_oob Whether to use out-of-band authentication.
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