#' Claim
#' 
#' Create a claim.
#' 
#' @examples
#' \dontrun{
#' claim <- Claim$new(url = "https://some-domain.com/Y/m/d/article-slug") 
#' }
#' 
#' @export
Claim <- R6::R6Class("Claim", 
  public = list(
    initialize = function(url, review = NULL, location = NULL, first_appearance = NULL, appearances = NULL, date = NULL){
      assert_that(!missing(url), msg = "Missing `url`")
      private$.url <- url
      private$.claimReviewed <- review
      private$.claimDate <- date
      private$.claimLocation <- location
      private$.claimFirstAppearance <- first_appearance
      private$.claimAppearances <- appearances
      invisible(self)
    },
    review_author = function(name = Sys.getenv("FACTCHECK_NAME"), image = NULL){
      assert_that(!nchar(name) > 0, msg = "Missing `name`")
      private$.claimReviewAuthor <- list(
        name = name, 
        imageUrl = image
      )
      invisible(self)
    },
    claim_author = function(name = NULL, job_title = NULL, image = NULL, same_as = NULL){
      assert_that(!missing(name) || missing(job_title), msg = "Missing `name` and/or `job_title`")
      private$.ClaimAuthor <- list(
        name = name, 
        jobTitle = job_title,
        imageUrl = image,
        sameAs = same_as
      )
      invisible(self)
    },
    rating = function(text = NULL, value = NULL, worst = NULL, best = NULL, image = NULL){
      private$.ClaimRating <- list(
        textualRating = text, 
        ratingValue = value,
        worstRating = worst,
        bestRating = best,
        imageUrl = image
      )
      invisible(self)
    },
    claim = function(){
      body <- list(
        claimReviewAuthor = private$.claimReviewAuthor,
        claimReviewMarkups = list(
          url = private$.url,
          claimReviewed = private$.claimReviewed,
          claimDate = private$.claimDate,
          claimLocation = private$.claimLocation,
          claimFirstAppearance = private$.claimFirstAppearance,
          claimAppearances = private$.claimAppearances,
          ClaimAuthor = private$.ClaimAuthor,
          ClaimRating = private$.ClaimRating
        )
      )

      url <- .build_url(endpoint = "pages", with_key = FALSE)

      # ge token if missing
      TK <- getOption("FACTCHECK_TOKEN")
      assert_that(!is.null(TK), msg = "No token, see `fact_token`")

      response <- POST(url, body = body, config(token = TK, verbose = FALSE), encode = "json", accept_json(), content_type("application/json"))
      stop_for_status(response, content(response)$error$message)
      content(response)
    }
  ),
  private = list(
    .url = NULL,
    .claimReviewed = NULL,
    .claimDate = NULL,
    .claimLocation = NULL,
    .claimFirstAppearance = NULL,
    .claimAppearances = NULL,
    .claimReviewAuthor = NULL,
    .ClaimAuthor = NULL,
    .ClaimRating = NULL
  )
)