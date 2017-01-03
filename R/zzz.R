pl_GET <- function(url, ...) {
  cli <- crul::HttpClient$new(url = url)
  res <- cli$get(...)
  res$raise_for_status()
  res$parse("UTF-8")
}

pl_base <- function() 'https://pleiades.stoa.org/api'

pl_cache_path <- function() rappdirs::user_cache_dir("pleiades")

check4sqlite <- function() {
  if (!requireNamespace("RSQLite", quietly = TRUE)) {
    stop("Please install 'RSQLite'", call. = FALSE)
  } else {
    invisible(TRUE)
  }
}
