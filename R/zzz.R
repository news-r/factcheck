.onAttach <- function(...) {
  key <- Sys.getenv("FACTCHECK_API_KEY")

  msg <- "No API key found, see `factcheck_key`"
  if(nchar(key) > 1) msg <- "API key loaded!"

  packageStartupMessage(msg)
}