#' Get Pleiades status data, number of places, number of locations,
#' number of names
#'
#' @export
#' @param ... Curl options, see \code{\link[curl]{curl_options}}
#' @examples \dontrun{
#' pl_status()
#' }
pl_status <- function(...) {
  tt <- pl_GET(file.path(pl_base(), 'status'), ...)
  jsonlite::fromJSON(tt)
}
