#' OAuth
#' 
#' Create an OAuth token.
#' 
#' @param token A previously generated token or the path to the saved \code{RDS} file.
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
fact_token <- function(token = Sys.getenv("FACTCHECK_TOKEN"), id, secret){

  # set to NULL if does not exists
  if(nchar(token) == 0) token <- NULL

  if(!inherits(token, "Token2.0")){
    options(FACTCHECK_TOKEN = token)
    return(invisible(token))
  }

  if(!inherits(token, "character")){
    token <- readRDS(token)
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