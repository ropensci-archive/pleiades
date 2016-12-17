#' Cache data locally for later usage.
#'
#' @export
#' @param force (logical) Force update of the cache. Default: \code{FALSE}
#' @param ... Curl options, see \code{\link[curl]{curl_options}}
#' @param which (character) One of locations, names, or places.
#' @param prompt (logical) Prompt before clearing all files in cache?
#' No prompt used when DOIs passed in. Default: \code{TRUE}
#' @details data are cached in \code{rappdirs::user_cache_dir("pleiades")}
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
pl_cache <- function(force = FALSE, ...) {
  toget <- c('locations','names','places')
  cc <- if (!force) check_cache(force) else NULL
  if (is.null(cc)) {
    invisible(
      lapply(toget, fetch, path = pl_cache_path(), ...)
    )
  } else {
    cc
  }
}

#' @export
#' @rdname pl_cache
pl_cache_clear <- function(which = NULL, prompt = TRUE) {
  if (is.null(which)) {
    files <- list.files(pl_cache_path(), full.names = TRUE)
    resp <- if (prompt) {
      readline(
        sprintf("Sure you want to clear all %s files? [y/n]:  ", length(files))
      )
    } else {
      "y"
    }
    if (resp == "y") unlink(files, force = TRUE) else NULL
  } else {
    file <- switch(
      which,
      locations = "pleiades-locations-latest.csv.gz",
      names = "pleiades-names-latest.csv.gz",
      places = "pleiades-places-latest.csv.gz"
    )
    files <- file.path(pl_cache_path(), file)
    unlink(files, force = TRUE)
  }
}

check_cache <- function(force){
  if (!force) {
    check_path(pl_cache_path())
    ff <- list.files(pl_cache_path(), full.names = TRUE)
    if (length(ff) == 0) { NULL } else {
      res <- lapply(ff, file.info)
      df <- do.call(rbind, res)[,c('size','mtime')]
      df$size <- round(df$size/10^6, 2)
      df <- data.frame(
        file = sapply(row.names(df), basename, USE.NAMES = FALSE),
        df, row.names = NULL)
      names(df)[3] <- "updated_at"
      df
    }
  } else {
    NULL
  }
}

fetch <- function(which = 'locations', path, ...){
  check_path(path)
  url <- sprintf(ftpbase, which)
  cli <- crul::HttpClient$new(url = url)
  res <- cli$get(disk = file.path(path, basename(url)), ...)
  res$content
}

check_path <- function(x) dir.create(x, showWarnings = FALSE, recursive = TRUE)

ftpbase <- 'http://atlantides.org/downloads/pleiades/dumps/pleiades-%s-latest.csv.gz'
