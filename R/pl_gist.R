#' Make an interactive map to view in the browser as a Github gist
#'
#' @export
#' @importFrom gistr gist_create
#'
#' @param x Output from \code{\link{pl_places}}
#' @param file (character) File name (without file extension) for your geojson file. Default is
#' 'gistmap'.
#' @param description (character) Description for the Github gist, or leave to default
#' (=no description)
#' @param public (logical) Whether gist is public (default: TRUE)
#' @param browse (logical) If TRUE (default) the map opens in your default browser.
#' @param ... Further args passed on to \code{\link[httr]{POST}}
#' @description
#'
#' There are two ways to authorise gistr to work with your GitHub account:
#' \itemize{
#'  \item Generate a personal access token at
#'  https://help.github.com/articles/creating-an-access-token-for-command-line-use and record in
#'  the GITHUB_PAT envar.
#'  \item Interactively login into your GitHub account and authorise with OAuth.
#' }
#'
#' Using the GITHUB_PAT option is recommended.
#' @return Creates a gist on your Github account
#'
#' @examples \dontrun{
#' x <- pl_places(place_id=579885)
#' pl_gist(x)
#' }
pl_gist <- function(x, file=NULL, description = "", public = TRUE, browse = TRUE, ...){
  stopifnot(is(x, "pleiades"))
  geolist <- list(type="FeatureCollection", features=x[['features']])
  geojson <- jsonlite::toJSON(geolist, auto_unbox = TRUE)
  file <- if(is.null(file)) tempfile("pleiades", fileext = ".geojson") else file
  gist_create(code = geojson, description = description, public = public,
              filename = basename(file), ...)
}
