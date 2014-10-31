pleiades
=======



[![Build Status](https://api.travis-ci.org/ropensci/pleiades.png)](https://travis-ci.org/ropensci/pleiades)

An R client for [Pleiades](http://pleiades.stoa.org/home)

## Pleiades info

+ [Homepage](http://pleiades.stoa.org/home)
+ [API docs](http://api.pleiades.stoa.org/)

## Quick start

### Install


```r
install.packages("devtools")
devtools::install_github("ropensci/pleiades")
```


```r
library("pleiades")
```

### Status


```r
pl_status()
#> $num_places
#> [1] 34764
#> 
#> $num_locations
#> [1] 38700
#> 
#> $num_names
#> [1] 30163
```

### Places

`pl_places` uses the Pleiades API. Just a subst of output for brevity


```r
pl_places(place_id=579885)[1:2]
#> $connectsWith
#> $connectsWith[[1]]
#> [1] "579888"
#> 
#> $connectsWith[[2]]
#> [1] "580123"
#> 
#> $connectsWith[[3]]
#> [1] "146086514"
#> 
#> 
#> $recent_changes
#> $recent_changes[[1]]
#> $recent_changes[[1]]$modified
#> [1] "2013-08-14T13:24:29Z"
#> 
#> $recent_changes[[1]]$principal
#> [1] "arabinowitz"
#> 
#> 
#> $recent_changes[[2]]
#> $recent_changes[[2]]$modified
#> [1] "2013-07-16T19:29:26Z"
#> 
#> $recent_changes[[2]]$principal
#> [1] "jbecker"
```

### Search bulk files locally

Pleiades nicely provides their bulk data (for locations, names, and places) in various formats, including `.csv`. We've created three functions `pl_search_loc()`, `pl_search_names()`, and `pl_search_places()` to search each of those datasets. As these are relatively large (approx 40K rows by 30 columns), `dplyr` is a nice approach to dealing with big-ish data. At this time `dplyr` is a dependency. 

You can run `pl_cache()` first to get the raw data files from Pleiades


```r
pl_cache()
```

Or, that function is run internally in `pl_search*()` functions for you.

Search across all tables in one database, or separately locations, names, or places. You can return the data (that is, a `dplyr` representation of the data) if you don't pass anything to the function call:

Gives each table in a list


```r
pl_search()
#> [[1]]
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_all.sqlite3]
#> From: locations [38,641 x 26]
#> 
#>                                                     authors avgRating
#> 1  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 2  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 3  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 4  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 5  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 6  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 7  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 8  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 9  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 10 Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> ..                                                      ...       ...
#> Variables not shown: bbox (chr), created (chr), creators (chr),
#>   currentVersion (int), description (chr), featureTypes (chr), geometry
#>   (chr), id (chr), locationPrecision (chr), maxDate (dbl), minDate (dbl),
#>   modified (chr), numRatings (int), path (chr), pid (chr), reprLat (dbl),
#>   reprLatLong (chr), reprLong (dbl), tags (chr), timePeriods (chr),
#>   timePeriodsKeys (chr), timePeriodsRange (chr), title (chr), uid (chr)
#> 
#> [[2]]
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_all.sqlite3]
#> From: names [30,110 x 28]
#> 
#>                                                                authors
#> 1  Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 2             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 3             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 4             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 5             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 6             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 7             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 8             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 9             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 10            Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> ..                                                                 ...
#> Variables not shown: avgRating (dbl), bbox (chr), created (chr), creators
#>   (chr), currentVersion (int), description (chr), extent (chr), id (chr),
#>   locationPrecision (chr), maxDate (dbl), minDate (dbl), modified (chr),
#>   nameAttested (chr), nameLanguage (chr), nameTransliterated (chr),
#>   numRatings (int), path (chr), pid (chr), reprLat (dbl), reprLatLong
#>   (chr), reprLong (dbl), tags (chr), timePeriods (chr), timePeriodsKeys
#>   (chr), timePeriodsRange (chr), title (chr), uid (chr)
#> 
#> [[3]]
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_all.sqlite3]
#> From: places [34,702 x 26]
#> 
#>                                                                       authors
#> 1             Spann, P., DARMC, R. Talbert, R. Warner, S. Gillies, T. Elliott
#> 2         Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 3                    Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 4  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 5                    Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 6  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 7         Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 8                    Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 9  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 10        Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> ..                                                                        ...
#> Variables not shown: bbox (chr), connectsWith (chr), created (chr),
#>   creators (chr), currentVersion (int), description (chr), extent (chr),
#>   featureTypes (chr), geoContext (chr), hasConnectionsWith (chr), id
#>   (dbl), locationPrecision (chr), maxDate (dbl), minDate (dbl), modified
#>   (chr), path (chr), reprLat (dbl), reprLatLong (chr), reprLong (dbl),
#>   tags (chr), timePeriods (chr), timePeriodsKeys (chr), timePeriodsRange
#>   (chr), title (chr), uid (chr)
```

Locations only


```r
pl_search_loc()
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_locations.sqlite3]
#> From: locations [38,641 x 26]
#> 
#>                                                     authors avgRating
#> 1  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 2  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 3  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 4  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 5  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 6  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 7  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 8  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 9  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 10 Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> ..                                                      ...       ...
#> Variables not shown: bbox (chr), created (chr), creators (chr),
#>   currentVersion (int), description (chr), featureTypes (chr), geometry
#>   (chr), id (chr), locationPrecision (chr), maxDate (dbl), minDate (dbl),
#>   modified (chr), numRatings (int), path (chr), pid (chr), reprLat (dbl),
#>   reprLatLong (chr), reprLong (dbl), tags (chr), timePeriods (chr),
#>   timePeriodsKeys (chr), timePeriodsRange (chr), title (chr), uid (chr)
```

Or you can submit a query:


```r
pl_search_loc("SELECT * FROM locations limit 5")
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_locations.sqlite3]
#> From: <derived table> [?? x 26]
#> 
#>                                                     authors avgRating
#> 1  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 2  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 3  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 4  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> 5  Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies        NA
#> ..                                                      ...       ...
#> Variables not shown: bbox (chr), created (chr), creators (chr),
#>   currentVersion (int), description (chr), featureTypes (chr), geometry
#>   (chr), id (chr), locationPrecision (chr), maxDate (dbl), minDate (dbl),
#>   modified (chr), numRatings (int), path (chr), pid (chr), reprLat (dbl),
#>   reprLatLong (chr), reprLong (dbl), tags (chr), timePeriods (chr),
#>   timePeriodsKeys (chr), timePeriodsRange (chr), title (chr), uid (chr)
```

Search names


```r
pl_search_names("SELECT * FROM names limit 5")
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_names.sqlite3]
#> From: <derived table> [?? x 28]
#> 
#>                                                                authors
#> 1  Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 2             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 3             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 4             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 5             Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> ..                                                                 ...
#> Variables not shown: avgRating (dbl), bbox (chr), created (chr), creators
#>   (chr), currentVersion (int), description (chr), extent (chr), id (chr),
#>   locationPrecision (chr), maxDate (dbl), minDate (dbl), modified (chr),
#>   nameAttested (chr), nameLanguage (chr), nameTransliterated (chr),
#>   numRatings (int), path (chr), pid (chr), reprLat (dbl), reprLatLong
#>   (chr), reprLong (dbl), tags (chr), timePeriods (chr), timePeriodsKeys
#>   (chr), timePeriodsRange (chr), title (chr), uid (chr)
```

Search places


```r
pl_search_places("SELECT * FROM places limit 5")
#> Source: sqlite 3.8.6 [~/.pleiades//pleiades_places.sqlite3]
#> From: <derived table> [?? x 26]
#> 
#>                                                                       authors
#> 1             Spann, P., DARMC, R. Talbert, R. Warner, S. Gillies, T. Elliott
#> 2         Spann, P., R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 3                    Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> 4  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 5                    Spann, P., R. Warner, T. Elliott, R. Talbert, S. Gillies
#> ..                                                                        ...
#> Variables not shown: bbox (chr), connectsWith (chr), created (chr),
#>   creators (chr), currentVersion (int), description (chr), extent (chr),
#>   featureTypes (chr), geoContext (chr), hasConnectionsWith (chr), id
#>   (dbl), locationPrecision (chr), maxDate (dbl), minDate (dbl), modified
#>   (chr), path (chr), reprLat (dbl), reprLatLong (chr), reprLong (dbl),
#>   tags (chr), timePeriods (chr), timePeriodsKeys (chr), timePeriodsRange
#>   (chr), title (chr), uid (chr)
```

### Create geojson map on Github Gists


```r
res <- pl_place(place_id=579885)
pl_gist(res)
```

Which opens up the gist in your default browser, as long as `browse=TRUE` (default).

![](http://f.cl.ly/items/251s021t0c020u0K3942/Screen%20Shot%202014-07-31%20at%2010.34.02%20AM.png)

### Meta

* Please report any issues or bugs](https://github.com/ropensci/pleiades/issues).
* License: MIT
* Get citation information for `pleiades` in R doing `citation(package = 'pleiades')`

[![](http://ropensci.org/public_images/github_footer.png)](http://ropensci.org)
