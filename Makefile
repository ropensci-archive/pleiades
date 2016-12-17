all: move rmd2md

move:
		cp inst/vign/pleiades_vignette.md vignettes;\
		cp -r inst/vign/img/ vignettes/img/

rmd2md:
		cd vignettes;\
		mv pleiades_vignette.md pleiades_vignette.Rmd
