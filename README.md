pleiades
========



[![Build Status](https://travis-ci.org/ropensci/pleiades.svg?branch=master)](https://travis-ci.org/ropensci/pleiades)
[![codecov.io](https://codecov.io/github/ropensci/pleiades/coverage.svg?branch=master)](https://codecov.io/github/ropensci/pleiades?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/pleiades)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/pleiades)](https://cran.r-project.org/package=pleiades)

R client for [Pleiades](https://pleiades.stoa.org/home)

## Pleiades info

+ [Homepage](https://pleiades.stoa.org/home)
+ [API docs](http://api.pleiades.stoa.org/)

## Install

More stable CRAN version


```r
install.packages("pleiades")
```

Dev version


```r
devtools::install_github("ropensci/pleiades")
```


```r
library("pleiades")
```

## Status


```r
pl_status()
#> $num_places
#> [1] 35250
#> 
#> $num_locations
#> [1] 39385
#> 
#> $num_names
#> [1] 31125
```

## Places

`pl_places` uses the Pleiades API. Just a subst of output for brevity


```r
pl_places(place_id = 579885)[1:2]
#> $features
#> list()
#> 
#> $contributors
#> $contributors[[1]]
#> $contributors[[1]]$username
#> [1] "pmotylewicz"
#> 
#> $contributors[[1]]$homepage
#> NULL
#> 
#> $contributors[[1]]$name
#> [1] "Pierre Motylewicz"
#> 
#> $contributors[[1]]$uri
#> [1] "https://pleiades.stoa.org/author/pmotylewicz"
#> 
#> 
#> $contributors[[2]]
#> $contributors[[2]]$username
#> [1] "sgillies"
#> 
#> $contributors[[2]]$homepage
#> NULL
#> 
#> $contributors[[2]]$name
#> [1] "Sean Gillies"
#> 
#> $contributors[[2]]$uri
#> [1] "https://pleiades.stoa.org/author/sgillies"
#> 
#> 
#> $contributors[[3]]
#> $contributors[[3]]$username
#> [1] "jahlfeldt"
#> 
#> $contributors[[3]]$homepage
#> NULL
#> 
#> $contributors[[3]]$name
#> [1] "Johan Åhlfeldt"
#> 
#> $contributors[[3]]$uri
#> [1] "https://pleiades.stoa.org/author/jahlfeldt"
#> 
#> 
#> $contributors[[4]]
#> $contributors[[4]]$username
#> NULL
#> 
#> $contributors[[4]]$name
#> [1] "Chelsea Lee"
#> 
#> 
#> $contributors[[5]]
#> $contributors[[5]]$username
#> [1] "alecpm"
#> 
#> $contributors[[5]]$homepage
#> NULL
#> 
#> $contributors[[5]]$name
#> [1] "Alec Mitchell"
#> 
#> $contributors[[5]]$uri
#> [1] "https://pleiades.stoa.org/author/alecpm"
#> 
#> 
#> $contributors[[6]]
#> $contributors[[6]]$username
#> [1] "jbecker"
#> 
#> $contributors[[6]]$homepage
#> NULL
#> 
#> $contributors[[6]]$name
#> [1] "Jeffrey Becker"
#> 
#> $contributors[[6]]$uri
#> [1] "https://pleiades.stoa.org/author/jbecker"
#> 
#> 
#> $contributors[[7]]
#> $contributors[[7]]$username
#> [1] "arabinowitz"
#> 
#> $contributors[[7]]$homepage
#> NULL
#> 
#> $contributors[[7]]$name
#> [1] "Adam Rabinowitz"
#> 
#> $contributors[[7]]$uri
#> [1] "https://pleiades.stoa.org/author/arabinowitz"
#> 
#> 
#> $contributors[[8]]
#> $contributors[[8]]$username
#> [1] "thomase"
#> 
#> $contributors[[8]]$homepage
#> NULL
#> 
#> $contributors[[8]]$name
#> [1] "Tom Elliott"
#> 
#> $contributors[[8]]$uri
#> [1] "https://pleiades.stoa.org/author/thomase"
#> 
#> 
#> $contributors[[9]]
#> $contributors[[9]]$username
#> NULL
#> 
#> $contributors[[9]]$name
#> [1] "DARMC"
#> 
#> 
#> $contributors[[10]]
#> $contributors[[10]]$username
#> [1] "rbrowning"
#> 
#> $contributors[[10]]$homepage
#> NULL
#> 
#> $contributors[[10]]$name
#> [1] "Rachaelle L Browning"
#> 
#> $contributors[[10]]$uri
#> [1] "https://pleiades.stoa.org/author/rbrowning"
#> 
#> 
#> $contributors[[11]]
#> $contributors[[11]]$username
#> NULL
#> 
#> $contributors[[11]]$name
#> [1] "April Kissinger"
#> 
#> 
#> $contributors[[12]]
#> $contributors[[12]]$username
#> NULL
#> 
#> $contributors[[12]]$name
#> [1] "Eric Shea"
#> 
#> 
#> $contributors[[13]]
#> $contributors[[13]]$username
#> NULL
#> 
#> $contributors[[13]]$name
#> [1] "R. Talbert"
#> 
#> 
#> $contributors[[14]]
#> $contributors[[14]]$username
#> [1] "rmhorne"
#> 
#> $contributors[[14]]$homepage
#> NULL
#> 
#> $contributors[[14]]$name
#> [1] "Ryan Horne"
#> 
#> $contributors[[14]]$uri
#> [1] "https://pleiades.stoa.org/author/rmhorne"
#> 
#> 
#> $contributors[[15]]
#> $contributors[[15]]$username
#> [1] "swright"
#> 
#> $contributors[[15]]$homepage
#> NULL
#> 
#> $contributors[[15]]$name
#> [1] "Sterling Wright"
#> 
#> $contributors[[15]]$uri
#> [1] "https://pleiades.stoa.org/author/swright"
```

## Search bulk files locally

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
#> Source:   query [?? x 25]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_all.sqlite3]
#> 
#>                                                     authors
#>                                                       <chr>
#> 1                                                Becker, J.
#> 2                                                Becker, J.
#> 3          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 4  Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 5          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 6          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 7          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 8          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 9  Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 10         Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> # ... with more rows, and 24 more variables: bbox <chr>, created <chr>,
#> #   creators <chr>, currentVersion <int>, description <chr>,
#> #   featureType <chr>, geometry <chr>, id <chr>, locationPrecision <chr>,
#> #   locationType <chr>, maxDate <int>, minDate <int>, modified <chr>,
#> #   path <chr>, pid <chr>, reprLat <dbl>, reprLatLong <chr>,
#> #   reprLong <dbl>, tags <chr>, timePeriods <chr>, timePeriodsKeys <chr>,
#> #   timePeriodsRange <chr>, title <chr>, uid <chr>
#> 
#> [[2]]
#> Source:   query [?? x 26]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_all.sqlite3]
#> 
#>                                                                authors
#>                                                                  <chr>
#> 1             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 2             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 3             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 4                                                           Becker, J.
#> 5  Spann, P., R. Warner, R. Talbert, S. Gillies, T. Elliott, J. Becker
#> 6             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 7             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 8             Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 9                                                           Becker, J.
#> 10            Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> # ... with more rows, and 25 more variables: bbox <chr>, created <chr>,
#> #   creators <chr>, currentVersion <int>, description <chr>, extent <chr>,
#> #   id <chr>, locationPrecision <chr>, maxDate <int>, minDate <int>,
#> #   modified <chr>, nameAttested <chr>, nameLanguage <chr>,
#> #   nameTransliterated <chr>, path <chr>, pid <chr>, reprLat <dbl>,
#> #   reprLatLong <chr>, reprLong <dbl>, tags <chr>, timePeriods <chr>,
#> #   timePeriodsKeys <chr>, timePeriodsRange <chr>, title <chr>, uid <chr>
#> 
#> [[3]]
#> Source:   query [?? x 26]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_all.sqlite3]
#> 
#>                                                                       authors
#>                                                                         <chr>
#> 1                                                      Becker, J., T. Elliott
#> 2                                                      Becker, J., T. Elliott
#> 3  Spann, P., DARMC, R. Talbert, S. Gillies, R. Warner, J. Becker, T. Elliott
#> 4         Spann, P., R. Warner, R. Talbert, S. Gillies, T. Elliott, J. Becker
#> 5                    Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 6  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 7                    Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 8  Spann, P., DARMC, R. Talbert, R. Warner, J. Becker, S. Gillies, T. Elliott
#> 9         Spann, P., R. Warner, R. Talbert, S. Gillies, T. Elliott, J. Becker
#> 10 Spann, P., DARMC, R. Talbert, J. Becker, R. Warner, S. Gillies, T. Elliott
#> # ... with more rows, and 25 more variables: bbox <chr>,
#> #   connectsWith <chr>, created <chr>, creators <chr>,
#> #   currentVersion <int>, description <chr>, extent <chr>,
#> #   featureTypes <chr>, geoContext <chr>, hasConnectionsWith <chr>,
#> #   id <dbl>, locationPrecision <chr>, maxDate <int>, minDate <int>,
#> #   modified <chr>, path <chr>, reprLat <dbl>, reprLatLong <chr>,
#> #   reprLong <dbl>, tags <chr>, timePeriods <chr>, timePeriodsKeys <chr>,
#> #   timePeriodsRange <chr>, title <chr>, uid <chr>
```

Locations only


```r
pl_search_loc()
#> Source:   query [?? x 25]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_locations.sqlite3]
#> 
#>                                                     authors
#>                                                       <chr>
#> 1                                                Becker, J.
#> 2                                                Becker, J.
#> 3          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 4  Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 5          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 6          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 7          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 8          Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 9  Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 10         Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> # ... with more rows, and 24 more variables: bbox <chr>, created <chr>,
#> #   creators <chr>, currentVersion <int>, description <chr>,
#> #   featureType <chr>, geometry <chr>, id <chr>, locationPrecision <chr>,
#> #   locationType <chr>, maxDate <int>, minDate <int>, modified <chr>,
#> #   path <chr>, pid <chr>, reprLat <dbl>, reprLatLong <chr>,
#> #   reprLong <dbl>, tags <chr>, timePeriods <chr>, timePeriodsKeys <chr>,
#> #   timePeriodsRange <chr>, title <chr>, uid <chr>
```

Or you can submit a query:


```r
pl_search_loc("SELECT * FROM locations limit 5")
#> Source:   query [?? x 25]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_locations.sqlite3]
#> 
#>                                                    authors
#>                                                      <chr>
#> 1                                               Becker, J.
#> 2                                               Becker, J.
#> 3         Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> 4 Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 5         Spann, P., D. R. Talbert, T. Elliott, S. Gillies
#> # ... with 24 more variables: bbox <chr>, created <chr>, creators <chr>,
#> #   currentVersion <int>, description <chr>, featureType <chr>,
#> #   geometry <chr>, id <chr>, locationPrecision <chr>, locationType <chr>,
#> #   maxDate <int>, minDate <int>, modified <chr>, path <chr>, pid <chr>,
#> #   reprLat <dbl>, reprLatLong <chr>, reprLong <dbl>, tags <chr>,
#> #   timePeriods <chr>, timePeriodsKeys <chr>, timePeriodsRange <chr>,
#> #   title <chr>, uid <chr>
```

Search names


```r
pl_search_names("SELECT * FROM names limit 5")
#> Source:   query [?? x 26]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_names.sqlite3]
#> 
#>                                                               authors
#>                                                                 <chr>
#> 1            Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 2            Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 3            Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> 4                                                          Becker, J.
#> 5 Spann, P., R. Warner, R. Talbert, S. Gillies, T. Elliott, J. Becker
#> # ... with 25 more variables: bbox <chr>, created <chr>, creators <chr>,
#> #   currentVersion <int>, description <chr>, extent <chr>, id <chr>,
#> #   locationPrecision <chr>, maxDate <int>, minDate <int>, modified <chr>,
#> #   nameAttested <chr>, nameLanguage <chr>, nameTransliterated <chr>,
#> #   path <chr>, pid <chr>, reprLat <dbl>, reprLatLong <chr>,
#> #   reprLong <dbl>, tags <chr>, timePeriods <chr>, timePeriodsKeys <chr>,
#> #   timePeriodsRange <chr>, title <chr>, uid <chr>
```

Search places


```r
pl_search_places("SELECT * FROM places limit 5")
#> Source:   query [?? x 26]
#> Database: sqlite 3.11.1 [/Users/sacmac/Library/Caches/pleiades/pleiades_places.sqlite3]
#> 
#>                                                                      authors
#>                                                                        <chr>
#> 1                                                     Becker, J., T. Elliott
#> 2                                                     Becker, J., T. Elliott
#> 3 Spann, P., DARMC, R. Talbert, S. Gillies, R. Warner, J. Becker, T. Elliott
#> 4        Spann, P., R. Warner, R. Talbert, S. Gillies, T. Elliott, J. Becker
#> 5                   Spann, P., R. Warner, R. Talbert, T. Elliott, S. Gillies
#> # ... with 25 more variables: bbox <chr>, connectsWith <chr>,
#> #   created <chr>, creators <chr>, currentVersion <int>,
#> #   description <chr>, extent <chr>, featureTypes <chr>, geoContext <chr>,
#> #   hasConnectionsWith <chr>, id <dbl>, locationPrecision <chr>,
#> #   maxDate <int>, minDate <int>, modified <chr>, path <chr>,
#> #   reprLat <dbl>, reprLatLong <chr>, reprLong <dbl>, tags <chr>,
#> #   timePeriods <chr>, timePeriodsKeys <chr>, timePeriodsRange <chr>,
#> #   title <chr>, uid <chr>
```

## Create geojson map on Github Gists


```r
res <- pl_places(place_id = 462471)
pl_gist(res)
```

Which opens up the gist in your default browser, as long as `browse=TRUE` (default).

![thing](http://f.cl.ly/items/251s021t0c020u0K3942/Screen%20Shot%202014-07-31%20at%2010.34.02%20AM.png)

### Meta

* Please report any [issues or bugs](https://github.com/ropensci/pleiades/issues).
* License: MIT
* Get citation information for `pleiades` in R doing `citation(package = 'pleiades')`
* Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
