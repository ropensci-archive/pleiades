#' Get data for a place given a place ID
#'
#' @export
#' @param place_id (integer/numeric) A place ID
#' @param ... Curl debugging arguments passed on to \code{\link[httr]{GET}}
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
