## Test environments

* local OS X install, R 3.4.0 patched
* ubuntu 12.04 (on travis-ci), R 3.4.0
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

  License components with restrictions and base license permitting such:
    MIT + file LICENSE
  File 'LICENSE':
    YEAR: 2017
    COPYRIGHT HOLDER: Scott Chamberlain

## Reverse dependencies

There are no reverse dependencies.

---

This version updates dependencies and changes internals accordingly
for those new deps, due to changes in dplyr.

I noticed that on winbuilder R-devel there is an odd error about EOF, 
but it builds fine without problems on winbuilder R-release, so I 
assume it’s okay.

Thanks!
Scott Chamberlain
