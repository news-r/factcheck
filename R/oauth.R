#' OAuth
#' 
#' Create an OAuth token.
#' 
#' @param token A previously generated token.
#' @param id,secret Your credentials.
#' 
#' @return Invisibly returns an object of class \code{Token2.0}.
#' 
#' @examples
#' \dontrun{
#' token <- fact_token(id = "XxxXXXxxxX", secret = "XXxxXxX")
#' 
#' # In future sessions pass Token  object
#' fact_token(token)
#' }
#' 
#' @export
fact_token <- function(token = NULL, id, secret){

  if(!is.null(token)){
    options(FACTCHECK_TOKEN = token)
    return(invisible(token))
  }

  key <- id # fack

  if (missing(key) || missing(secret)) {
    stop("Missing client `id` or `secret`", call. = FALSE)
  }

  google <- httr::oauth_endpoints("google")

  # build app
  app <- httr::oauth_app("news-r", key, secret)

  # set scope
  scope <- paste0("https://www.googleapis.com/auth/userinfo.email")

  # OAuth
  token <- httr::oauth2.0_token(google, app,
                                scope = scope,
                                cache = FALSE)


  options(FACTCHECK_TOKEN = token)
  invisible(token)
}