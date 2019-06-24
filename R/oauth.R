#' OAuth
#' 
#' Create an OAuth token.
#' 
#' @param token A previously generated token.
#' @param cache Whether to cache the token.
#' @param use_oob Whether to use out-of-band authentication.
#' 
#' @return Invisibly returns an object of class \code{Token2.0}.
#' 
#' @examples
#' \dontrun{
#' token <- fact_token()
#' 
#' # In future sessions pass Token  object
#' fact_token(token)
#' }
#' 
#' @export
fact_token <- function(token = NULL, cache = gargle::gargle_oauth_cache(), 
  use_oob = gargle::gargle_oob_default()) {

  if(is.null(token))
    token <- gargle::token_fetch(
      cache = cache,
      use_oob = use_oob,
      scopes = "https://www.googleapis.com/auth/userinfo.email"
    )

  options(FACTCHECK_TOKEN = token)
  invisible(token)
}