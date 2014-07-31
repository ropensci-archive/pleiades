pleiades
=======

[![Build Status](https://api.travis-ci.org/sckott/pleiades.png)](https://travis-ci.org/sckott/pleiades)

A general purpose R interface to [Digital Ocean](https://www.digitalocean.com/)

### Pleiades info

+ [Homepage](http://pleiades.stoa.org/home)
+ [API docs](http://api.pleiades.stoa.org/)


### Quick start

#### Install

```coffee
devtools::install_github("sckott/pleiades")
library("pleiades")
```

#### Status

```coffee
pl_status()
```

```coffee
$num_places
[1] 34764

$num_locations
[1] 38698

$num_names
[1] 30279
```

#### Places

```coffee
pl_places(place_id=579885)
```

```coffee
$connectsWith
$connectsWith[[1]]
[1] "579888"

$connectsWith[[2]]
[1] "580123"

$connectsWith[[3]]
[1] "146086514"


$recent_changes
$recent_changes[[1]]
$recent_changes[[1]]$modified
[1] "2013-08-14T13:24:29Z"

$recent_changes[[1]]$principal
[1] "arabinowitz"


$recent_changes[[2]]
$recent_changes[[2]]$modified
[1] "2013-07-16T19:29:26Z"

$recent_changes[[2]]$principal
[1] "jbecker"



$description
[1] "A major Greek city-state and the principal city of Attika."

...Cutoff
```

#### Create geojson map on Github Gists

```coffee
res <- pl_place(place_id=579885)
pl_gist(res)
```

```coffee
Your gist has been published
View gist at https://gist.github.com/sckott/cb25d4e497c9f0abe86f
Embed gist with <script src="https://gist.github.com/sckott/cb25d4e497c9f0abe86f.js"></script>
```

Which opens up the gist in your default browser, as long as `browse=TRUE` (default).

![](http://f.cl.ly/items/251s021t0c020u0K3942/Screen%20Shot%202014-07-31%20at%2010.34.02%20AM.png)
