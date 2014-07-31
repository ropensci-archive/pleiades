#' Get data for a place given a place ID
#' 
#' @param place_id A place ID
#' @param ... Curl debugging arguments, see \code{httr::config}
#' @examples \dontrun{
#' pl_places(place_id=579885)
#' }
pl_places <- function(place_id, ...){
  url <- sprintf('http://pleiades.stoa.org/places/%s/json', place_id)
  res <- GET(url, ...)
  if(res$status_code > 202) stop("Error occurred in API call, try again", call. = FALSE)
  tt <- content(res, as = "text")
  ll <- jsonlite::fromJSON(tt, FALSE)
  class(ll) <- "pleiades"
  ll
}