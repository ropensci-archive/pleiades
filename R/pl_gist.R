#' Make an interactive map to view in the browser as a Github gist
#' 
#' @export
#' 
#' @param x Output from pl_places
#' @param outfile File name (without file extension) for your geojson file. Default is 'gistmap'.
#' @param description Description for the Github gist, or leave to default (=no description)
#' @param browse If TRUE (default) the map opens in your default browser.
#' @description 
#' You will be asked ot enter you Github credentials (username, password) during
#' each session, but only once for each session. Alternatively, you could enter
#' your credentials into your .Rprofile file with the entries
#' 
#' \itemize{
#'  \item options(github.username = 'your_github_username')
#'  \item options(github.password = 'your_github_password')
#' }
#' 
#' then \code{pl_gist} will simply read those options.
#' 
#' \code{pl_gist} has modified code from the rCharts package by Ramnath Vaidyanathan 
#' @return Creates a gist on your Github account, and prints out where the geojson file was
#' written on your machinee, the url for the gist, and an embed script in the console.
#' 
#' @examples \dontrun{
#' xxx <- pl_places(place_id=579885)
#' pl_gist(x=xxx)
#' }
pl_gist <- function(x, outfile=NULL, description = "", browse = TRUE){
  assert_that(is(x, "pleiades"))
  geolist <- list(type="FeatureCollection", features=x[['features']])
  geojson <- jsonlite::toJSON(geolist, auto_unbox = TRUE)
  file <- if(is.null(outfile)) tempfile("pleiades", fileext = ".json") else outfile
  write(geojson, file)
  tt <- pl_do_gist(file, description = description)
  if(browse) browseURL(tt)
}

#' Post a file as a Github gist
#' 
#' @export
#' @keywords internal
#' @param gist An object
#' @param description brief description of gist (optional)
#' @param public whether gist is public (default: TRUE)
#' @param browse If TRUE (default) the map opens in your default browser
pl_do_gist <- function(gist, description = "", public = TRUE, browse = TRUE) {
  dat <- 
    pl_create_gist(gist, description = description, public = public)
  credentials <- pl_get_credentials()
  response <- POST(url = "https://api.github.com/gists", 
                   body = dat, 
                   config = c(authenticate(getOption("github.username"), 
                                           getOption("github.password"), type = "basic"), 
                              add_headers(`User-Agent` = "Dummy")))
  stop_for_status(response)
  html_url <- content(response)$html_url
  message("Your gist has been published")
  message("View gist at ", paste("https://gist.github.com/", getOption("github.username"), 
                                 "/", basename(html_url), sep = ""))
  message("Embed gist with ", paste("<script src=\"https://gist.github.com/", getOption("github.username"), 
                                    "/", basename(html_url), ".js\"></script>", sep = ""))
  return(paste("https://gist.github.com/", getOption("github.username"), "/", basename(html_url), 
               sep = ""))
}

#' Function that takes a list of files and creates payload for API
#' @export
#' @keywords internal
#' @param filenames names of files to post
#' @param description brief description of gist (optional)
#' @param public whether gist is public (defaults to TRUE)
pl_create_gist <- function(filenames, description = "", public = TRUE) {
  files <- lapply(filenames, function(file) {
    x <- list(content = paste(readLines(file, warn = F), collapse = "\n"))
  })
  names(files) <- basename(filenames)
  body <- list(description = description, public = public, files = files)
  jsonlite::toJSON(body, pretty = TRUE, auto_unbox = TRUE)
}

#' Get Github credentials from use in console
#' @export
#' @keywords internal
pl_get_credentials <- function() {
  if (is.null(getOption("github.username"))) {
    username <- readline("Please enter your github username: ")
    options(github.username = username)
  }
  if (is.null(getOption("github.password"))) {
    password <- readline("Please enter your github password: ")
    options(github.password = password)
  }
}