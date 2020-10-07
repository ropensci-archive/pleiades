#' Get data for a place given a place ID
#'
#' @export
#' @param place_id (integer/numeric) A place ID
#' @param ... Curl options, see `curl::curl_options()`
#' @examples \dontrun{
#' pl_places(place_id = 462471)
#' }
pl_places <- function(place_id, ...) {
  url <- sprintf('%s/places/%s/json', pl_base(), place_id)
  tt <- pl_GET(url, ...)
  structure(jsonlite::fromJSON(tt, FALSE), class = "pleiades")
}
