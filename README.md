
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rksfun

<!-- badges: start -->

[![GitHub
issues](https://img.shields.io/github/issues/richardstoeckl/rksfun)](https://github.com/richardstoeckl/rksfun/issues)
[![GitHub
pulls](https://img.shields.io/github/issues-pr/richardstoeckl/rksfun)](https://github.com/richardstoeckl/rksfun/pulls)
<!-- badges: end -->

These are some commonly used functions in my work. I have created this
package to make my work easier. I hope you find it useful too.

## Installation instructions

Get the latest stable `R` release from
[CRAN](http://cran.r-project.org/). Then install the development version
from [GitHub](https://github.com/richardstoeckl/rksfun) with:

``` r
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}
BiocManager::install("richardstoeckl/rksfun")
```

## Citation

Below is the citation output from using `citation('rksfun')` in R.
Please run this yourself to check for any updates on how to cite
**rksfun**.

``` r
print(citation("rksfun"), bibtex = TRUE)
#> Warning in citation("rksfun"): could not determine year for 'rksfun' from
#> package DESCRIPTION file
#> To cite package 'rksfun' in publications use:
#> 
#>   Stöckl R (????). _rksfun: rksfun - a collection of usefull (to me)
#>   code_. R package version 0.0.0.9000,
#>   https://richardstoeckl.github.io/rksfun/,
#>   <https://github.com/richardstoeckl/rksfun>.
#> 
#> A BibTeX entry for LaTeX users is
#> 
#>   @Manual{,
#>     title = {rksfun: rksfun - a collection of usefull (to me) code},
#>     author = {Richard Stöckl},
#>     note = {R package version 0.0.0.9000, https://richardstoeckl.github.io/rksfun/},
#>     url = {https://github.com/richardstoeckl/rksfun},
#>   }
```

Please note that the `rksfun` was only made possible thanks to many
other R and bioinformatics software authors, which are cited either in
the vignettes and/or the paper(s) describing this package.

## Development tools

- Continuous code testing is possible thanks to [GitHub
  actions](https://www.tidyverse.org/blog/2020/04/usethis-1-6-0/)
  through *[usethis](https://CRAN.R-project.org/package=usethis)*,
  *[remotes](https://CRAN.R-project.org/package=remotes)*, and
  *[rcmdcheck](https://CRAN.R-project.org/package=rcmdcheck)* customized
  to use [Bioconductor’s docker
  containers](https://www.bioconductor.org/help/docker/) and
  *[BiocCheck](https://bioconductor.org/packages/3.20/BiocCheck)*.
- Code coverage assessment is possible thanks to
  [codecov](https://codecov.io/gh) and
  *[covr](https://CRAN.R-project.org/package=covr)*.
- The [documentation website](http://richardstoeckl.github.io/rksfun) is
  automatically updated thanks to
  *[pkgdown](https://CRAN.R-project.org/package=pkgdown)*.
- The code is styled automatically thanks to
  *[styler](https://CRAN.R-project.org/package=styler)*.
- The documentation is formatted thanks to
  *[devtools](https://CRAN.R-project.org/package=devtools)* and
  *[roxygen2](https://CRAN.R-project.org/package=roxygen2)*.

For more details, check the `dev` directory.

This package was developed using
*[biocthis](https://bioconductor.org/packages/3.20/biocthis)*.
