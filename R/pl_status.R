#' Get Pleiades status data, number of places, number of locations, number of names.
#' 
#' @export
#' @import httr jsonlite assertthat
#' 
#' @param ... Curl debugging arguments, see \code{httr::config}
#' @examples \dontrun{
#' pl_status()
#' }
pl_status <- function(...){
  url <- 'http://api.pleiades.stoa.org/status'
  res <- GET(url, ...)
  if(res$status_code > 202) stop("Error occurred in API call, try again", call. = FALSE)
  tt <- content(res, as = "text")
  jsonlite::fromJSON(tt)
}
