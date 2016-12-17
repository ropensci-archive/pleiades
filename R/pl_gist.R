#' Make an interactive map to view in the browser as a GitHub gist
#'
#' @export
#' @param x Output from \code{\link{pl_places}}
#' @param file (character) File name (without file extension) for your geojson
#' file. Default is 'gistmap'.
#' @param description (character) Description for the Github gist, or leave
#' to default (=no description)
#' @param public (logical) Whether gist is public (default: TRUE)
#' @param browse (logical) If TRUE (default) the map opens in your
#' default browser.
#' @param ... Curl options, see \code{\link[curl]{curl_options}}
#' @description
#'
#' There are two ways to authorise gistr to work with your GitHub account:
#' \itemize{
#'  \item Generate a personal access token at
#'https://help.github.com/articles/creating-an-access-token-for-command-line-use
#'and record in the GITHUB_PAT envar.
#'  \item Interactively login into your GitHub account and authorise with OAuth
#' }
#'
#' Using the GITHUB_PAT option is recommended.
#' @return Creates a gist on your GitHub account
#'
#' @examples \dontrun{
#' x <- pl_places(place_id = 462471)
#' pl_gist(x)
#' }
pl_gist <- function(x, file = NULL, description = "", public = TRUE,
                    browse = TRUE, ...) {
  UseMethod("pl_gist")
}

#' @export
pl_gist.default <- function(x, file = NULL, description = "", public = TRUE,
                    browse = TRUE, ...) {
  stop("no 'pl_gist' method for ", class(x), call. = FALSE)
}

#' @export
pl_gist.pleiades <- function(x, file = NULL, description = "", public = TRUE,
                    browse = TRUE, ...) {

  geolist <- list(type = "FeatureCollection", features = x[['features']])
  geojson <- jsonlite::toJSON(geolist, auto_unbox = TRUE)
  file <- if (is.null(file)) tempfile("pleiades", fileext = ".geojson") else file
  gistr::gist_create(code = geojson, description = description, public = public,
              filename = basename(file), ...)
}
