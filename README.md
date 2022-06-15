
<!-- README.md is generated from README.Rmd. Please edit that file -->

# projectstats

<!-- badges: start -->
<!-- badges: end -->

The goal of projectstats is to create an HTML email from Github data
pulled from the Github API.

## Installation

You can install the development version of projectstats from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("nmfs-fish-tools/projectstats")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(projectstats)
## basic example code
json_full <- get_issues(appname, key, secret, org, repo)
issues_html <- create_issue_table(json_full)
pr_html <- create_pr_table(json_full)
```

------------------------------------------------------------------------

## Disclaimer

The United States Department of Commerce (DOC) GitHub project code is
provided on an ‘as is’ basis and the user assumes responsibility for its
use. DOC has relinquished control of the information and no longer has
responsibility to protect the integrity, confidentiality, or
availability of the information. Any claims against the Department of
Commerce stemming from the use of its GitHub project will be governed by
all applicable Federal law. Any reference to specific commercial
products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.”

------------------------------------------------------------------------

<img src="https://raw.githubusercontent.com/nmfs-general-modeling-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png" height="75" alt="NOAA Fisheries">

[U.S. Department of Commerce](https://www.commerce.gov/) \| [National
Oceanographic and Atmospheric Administration](https://www.noaa.gov) \|
[NOAA Fisheries](https://www.fisheries.noaa.gov/)
