#' Search for a place, name or location.
#'
#' This function searches a locally created SQLite database created
#' from csv files.
#'
#' @export
#' @param query A place ID. If left NULL, returns the table, which is of
#' class \code{tbl}, which can then be passed on to other
#' \pkg{dplyr} functions.
#' @param path (character) Path to cache data in.
#' @param ... Further args passed on to \code{\link[dplyr]{tbl}}
#' @details On the first query if not run before, the function takes a bit
#' to get the raw data (if not already gotten), temporarily load the raw
#' csv data, then create a SQLite database, and create the pointer to it.
#' Subsequent calls should be very fast.
#'
#' There is a function \code{\link{pl_cache}}, used to download the raw
#' csv files. That function is run internally in these functions if you have
#' not run it before, or if only some fo the files are present.
#' @examples \dontrun{
#' pl_search()
#' pl_search_loc()
#' pl_search_names()
#' pl_search_places()
#'
#' pl_search_loc("SELECT * FROM locations limit 5")
#' pl_search_names("SELECT * FROM names limit 5")
#' pl_search_places("SELECT * FROM places limit 5")
#' pl_search("SELECT locations.bbox locations.pid
#'            FROM locations
#'            INNER JOIN names
#'            ON locations.pid=names.pid")
#'
#' locs <- pl_search("SELECT * FROM locations limit 1000") %>%
#'   select(pid, reprLat, reprLong)
#' nms <- pl_search("SELECT * FROM names limit 1000") %>% select(pid)
#' left_join(locs, nms, "pid", copy = TRUE) %>% collect %>% NROW
#' }

pl_search <- function(query = NULL, path = "~/.pleiades/", ...){
  # get data if it hasn't been downloaded yet
  pp <- vapply(c('locations','names','places'), function(x)
    getpath(path, x), "")
  if (!all(file.exists(pp))) pl_cache()

  if (!check_for_sql(path, 'all')) {
    loc <- read_csv(path, 'locations')
    nam <- read_csv(path, 'names')
    pla <- read_csv(path, 'places')
    con <- make_sql_conn(path, 'all')
    invisible(write_sql_table(con, 'locations', loc))
    invisible(write_sql_table(con, 'names', nam))
    invisible(write_sql_table(con, 'places', pla))
  } else {
    con <- make_sql_conn(path, 'all')
  }
  if (!is.null(query)) {
    tbl(con, sql(query), ...)
  } else {
    lapply(c('locations','names','places'), function(x) tbl(con, x))
  }
}

#' @export
#' @rdname pl_search
pl_search_loc <- function(query = NULL, path = "~/.pleiades/", ...){
  # get data if it hasn't been downloaded yet
  pp <- vapply(c('locations','names','places'), function(x) getpath(path, x), "")
  if (!all(file.exists(pp))) pl_cache()

  if (!check_for_sql(path)) {
    dat <- read_csv(path, 'locations')
    con <- make_sql_conn(path, 'locations')
    invisible(write_sql_table(con, 'locations', dat))
  } else {
    con <- make_sql_conn(path, 'locations')
  }
  if (!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "locations")
}

#' @export
#' @rdname pl_search
pl_search_names <- function(query = NULL, path = "~/.pleiades/", ...){
  # get data if it hasn't been downloaded yet
  pp <- vapply(c('locations','names','places'), function(x) getpath(path, x), "")
  if (!all(file.exists(pp))) pl_cache()

  if (!check_for_sql(path, 'names')) {
    dat <- read_csv(path, 'names')
    con <- make_sql_conn(path, 'names')
    invisible(write_sql_table(con, 'names', dat))
  } else {
    con <- make_sql_conn(path, 'names')
  }
  if (!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "names")
}

#' @export
#' @rdname pl_search
pl_search_places <- function(query = NULL, path = "~/.pleiades/", ...){
  # get data if it hasn't been downloaded yet
  pp <- vapply(c('locations','names','places'), function(x) getpath(path, x), "")
  if (!all(file.exists(pp))) pl_cache()

  if (!check_for_sql(path, 'places')) {
    dat <- read_csv(path, 'places')
    con <- make_sql_conn(path, 'places')
    invisible(write_sql_table(con, 'places', dat))
  } else {
    con <- make_sql_conn(path, 'places')
  }
  if (!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "places")
}

getpath <- function(path, x){
  file <- switch(
    x,
    locations = "pleiades-locations-latest.csv.gz",
    names = "pleiades-names-latest.csv.gz",
    places = "pleiades-places-latest.csv.gz")
  file.path(path, file)
}

read_csv <- function(path, x){
  read.csv(getpath(path, x), sep = ',',
           header = TRUE, comment.char = "",
           stringsAsFactors = FALSE)
}

check_for_sql <- function(path, which="locations"){
  file.exists(file.path(path, sprintf("pleiades_%s.sqlite3", which)))
}

make_sql_conn <- function(path, which="locations"){
  sqldb <- file.path(path, sprintf("pleiades_%s.sqlite3", which))
  src_sqlite(path = sqldb, create = TRUE)
}

write_sql_table <- function(con, name, table){
  copy_to(con, table, name, temporary = FALSE, indexes = list("created"))
}

# dbWriteTable(con, "locations", dat, row.names = FALSE)
# dbListTables(con)
# dbListFields(con, "locations")
#
# my_db <- src_sqlite(path = sqldb, create = TRUE)
# locations <- copy_to(my_db, dat, which, temporary = FALSE, indexes = list("created"))
# locdf <- tbl(my_db, "locations")
# tbl(my_db, sql("SELECT * FROM locations limit 5"))
