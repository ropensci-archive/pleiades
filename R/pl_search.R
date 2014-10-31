#' Search for a place, name or location.
#'
#' This function searches a locally cached file of their data catalog. See examples.
#'
#' @export
#' @param query A place ID. If left NULL, returns the table, which is of class \code{tbl},
#' which can then be passed on to other \code{dplyr} functions.
#' @param path (character) Path to cache data in.
#' @param ... Further args passed on to \code{\link[dplyr]{tbl}}
#' @details On the first query if not run before, the function takes a bit to load the raw csv
#' data, then create a SQLite database, and create the pointer to it. Subsequent calls should
#' be very fast.
#' @examples \dontrun{
#' pl_search_loc()
#' pl_search_names()
#' pl_search_places()
#'
#' pl_search_loc("SELECT * FROM locations limit 5")
#' pl_search_names(query = "SELECT * FROM names limit 5")
#' pl_search_places("SELECT * FROM places limit 5")
#' }
pl_search_loc <- function(query = NULL, path = "~/.pleiades/", ...){
  if(!check_for_sql(path)){
    dat <- read_csv(path, 'locations')
    con <- make_sql_conn(path, 'locations')
    invisible(write_sql_table(con, 'locations', dat))
  } else {
    con <- make_sql_conn(path, 'locations')
  }
  if(!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "locations")
}

#' @export
#' @rdname pl_search_loc
pl_search_names <- function(query = NULL, path = "~/.pleiades/", ...){
  if(!check_for_sql(path, 'names')){
    dat <- read_csv(path, 'names')
    con <- make_sql_conn(path, 'names')
    invisible(write_sql_table(con, 'names', dat))
  } else {
    con <- make_sql_conn(path, 'names')
  }
  if(!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "names")
}

#' @export
#' @rdname pl_search_loc
pl_search_places <- function(query = NULL, path = "~/.pleiades/", ...){
  if(!check_for_sql(path, 'places')){
    dat <- read_csv(path, 'places')
    con <- make_sql_conn(path, 'places')
    invisible(write_sql_table(con, 'places', dat))
  } else {
    con <- make_sql_conn(path, 'places')
  }
  if(!is.null(query)) tbl(con, sql(query), ...) else tbl(con, "places")
}

getpath <- function(path, x){
  file <- switch(x,
                 locations="pleiades-locations-latest.csv.gz",
                 names="pleiades-names-latest.csv.gz",
                 places="pleiades-places-latest.csv.gz")
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
