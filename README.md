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

Just a subst of output for brevity


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
