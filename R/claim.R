#' Claim
#' 
#' Create a claim.
#' 
#' @export
Claim <- R6::R6Class("Claim", 
  public = list(
    initialize = function(url, review = NULL, location = NULL, first_appearance = NULL, appearances = NULL, date = Sys.Date()){
      assert_that(!missing(url), msg = "Missing `url`")
      private$.url <- url
      private$.claimReviewed <- review
      private$.claimDate <- date
      private$.claimLocation <- location
      private$.claimFirstAppearance <- first_appearance
      private$.claimAppearances <- appearances
    },
    author = function(name = Sys.getenv("FACTCHECK_NAME"), image = NULL){
      assert_that(!nchar(name) > 0, msg = "Missing `name`")
      private$.claimAuthor <- list(
        name = name, 
        image = image
      )
      invisible(self)
    },
    claim = function(){
      body <- list(
        url = private$.url,
        claimReviewed = private$.claimReviewed,
        claimDate = as.character(private$.claimDate),
        claimLocation = private$.claimLocation,
        claimFirstAppearance = private$.claimFirstAppearance,
        claimAppearances = private$.claimAppearances,
        claimAuthor = private$.claimAuthor
      )

      url <- .build_url(endpoint = "pages")

      # ge token if missing
      TK <- getOption("FACTCHECK_TOKEN")
      if(is.null(TK)) TK <- fact_token()

      response <- POST(url, body = body, config(token = TK))
      stop_for_status(response)
      content(response)
    }
  ),
  private = list(
    .url = NULL,
    .claimReviewed = NULL,
    .claimDate = Sys.Date(),
    .claimLocation = NULL,
    .claimFirstAppearance = NULL,
    .claimAppearances = NULL,
    .claimAuthor = NULL
  )
)