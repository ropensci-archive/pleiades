pl_GET <- function(url, ...) {
  cli <- crul::HttpClient$new(url = url)
  res <- cli$get(...)
  res$parse()
}

pl_base <- function() 'https://pleiades.stoa.org/api'

pl_cache_path <- function() rappdirs::user_cache_dir("pleiades")
