#' Check
#'
#' Fact Check publishers or queries.
#'
#' @param q Textual query string. Required unless \code{publisheer} is specified.
#' @param lang The BCP-47 language code, such as \code{en-US} or \code{sr-Latn}. 
#' Can be used to restrict results by language, though we do not currently consider the region.
#' @param publisher The review publisher site to filter results by, e.g. \code{nytimes.com}.
#' @param days_old The maximum age of the returned search results, in days. 
#' Age is determined by either claim date or review date, whichever is newer.
#' @param pages Number of pages of results to fecth.
#'
#' @examples
#' \dontrun{
#' # Fact checks and claims on Trump only in English
#' fact_check("Trump", lang = "en-US")
#' 
#' # fact checks of the New York Times
#' fact_check(publisher = "nytimes.com")
#'}
#'
#' @export
fact_check <- function(q = NULL, lang = NULL, publisher = NULL, days_old = NULL, pages = 1){

  .get(
    query = q, 
    languageCode = lang, 
    reviewPublisherSiteFilter = publisher, 
    maxAgeDays = days_old,
    pages = pages,
    pageSize = 50,
    endpoint = "claims:search"
  )

}