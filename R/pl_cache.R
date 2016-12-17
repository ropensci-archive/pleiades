#' Cache data locally for later usage.
#'
#' @import dplyr
#' @export
#' @param path (character) Path to cache data in.
#' @param overwrite (logical) Overwrite existing files?
#' @param force (logical) Force update of the cache. Default: \code{FALSE}
#' @param ... Curl options, see \code{\link[curl]{curl_options}}
#' @param which (character) One of locations, names, or places.
#' @param prompt (logical) Prompt before clearing all files in cache?
#' No prompt used when DOIs passed in. Default: \code{TRUE}
#' @examples \dontrun{
#' pl_cache()
#' pl_cache(force = TRUE)
#'
#' # clear all files
#' pl_cache_clear()
#'
#' # clear a single file
#' pl_cache_clear(which = "locations")
#' pl_cache_clear(which = "places")
#' pl_cache_clear(which = "names")
#' }
pl_cache <- function(path = "~/.pleiades/", overwrite = TRUE, force = FALSE, ...) {
  toget <- c('locations','names','places')
  cc <- if (!force) check_cache(force, path) else NULL
  if (is.null(cc)) invisible(lapply(toget, fetch, path = path,
                                    overwrite = overwrite, ...)) else cc
}

#' @export
#' @rdname pl_cache
pl_cache_clear <- function(path="~/.pleiades/", which=NULL, prompt=TRUE){
  if (is.null(which)) {
    files <- list.files(path, full.names = TRUE)
    resp <- if (prompt) readline(sprintf("Sure you want to clear all %s files? [y/n]:  ", length(files))) else "y"
    if (resp == "y") unlink(files, force = TRUE) else NULL
  } else {
    file <- switch(which,
                   locations = "pleiades-locations-latest.csv.gz",
                   names = "pleiades-names-latest.csv.gz",
                   places = "pleiades-places-latest.csv.gz")
    files <- file.path(path, file)
    unlink(files, force = TRUE)
  }
}

check_cache <- function(force, path){
  if (!force) {
    check_path(path)
    ff <- list.files(path, full.names = TRUE)
    if (length(ff) == 0) { NULL } else {
      res <- lapply(ff, file.info)
      df <- do.call(rbind, res)[,c('size','mtime')]
      df$size <- round(df$size/10^6, 2)
      df <- data.frame(file = sapply(row.names(df), basename, USE.NAMES = FALSE), df, row.names = NULL)
      names(df)[3] <- "updated_at"
      df
    }
  } else {
    NULL
  }
}

fetch <- function(which = 'locations', path, overwrite, ...){
  check_path(path)
  url <- sprintf(ftpbase, which)
  res <- GET(url, write_disk(path = file.path(path, basename(url)), overwrite = overwrite), ...)
  stop_for_status(res)
  stopifnot(res$headers$`content-type` == "application/x-gzip")
  res$request$writer[[1]]
}

check_path <- function(x) dir.create(x, showWarnings = FALSE, recursive = TRUE)
ftpbase <- 'http://atlantides.org/downloads/pleiades/dumps/pleiades-%s-latest.csv.gz'
