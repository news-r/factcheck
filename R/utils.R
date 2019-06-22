BASE_URL <- "https://factchecktools.googleapis.com"
BASE_PATH <- "v1alpha1"

.build_url <- function(..., endpoint) {
  url <- parse_url(BASE_URL)
  url$path <- c(BASE_PATH, endpoint)
  url$query <- list(..., key = .get_key())
  url$scheme <- "https"
  build_url(url)
}

.get_key <- function(){
  key <- Sys.getenv("FACTCHECK_API_KEY")
  assert_that(nchar(key) > 0, msg = "Missing key, see `factcheck_key`")
  return(key)
}

.get <- function(..., pages = 1, endpoint){
  
  # init
  p <- 0
  claims <- list()
  token <- "init"

  while(p < pages && !is.null(token)){
    if(p == 0) token <- NULL # init token
    p <- p + 1

    url <- .build_url(..., pageToken = token, endpoint = endpoint)

    response <- GET(url)
    stop_for_status(response)
    content <- content(response)
    token <- content$nextPageToken

    if(pages > 1)
      Sys.sleep(1)

    claims <- append(claims, content$claims)
  }

  .parse(claims)
} 

.parse <- function(content){
  purrr::map_dfr(content, tibble::as_tibble)
}