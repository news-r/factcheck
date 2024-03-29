
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- badges: start -->

[![Travis build
status](https://travis-ci.org/news-r/factcheck.svg?branch=master)](https://travis-ci.org/news-r/factcheck)
<!-- badges: end -->

# factcheck

Fact check publishers or queries, create claims and more with the
[Google FactCheck Toolbox](https://toolbox.google.com/factcheck).

## Installation

``` r
# install.packages("remotes")
remotes::install_github("news-r/factcheck")
```

## Setup

Get a free key from the [Google
Console](https://console.cloud.google.com).

``` r
factcheck_key("xxXXxxXx")
```

Note that you can specify the `FACTCHECK_API_KEY` key as an environment
variable in your `.Renviron` for convenience.

The above key will work for the `fact_check` function, other function to
create, update, or delete your claims will require OAuth 2.0
authentication using `fact_token`.

## ROADMAP

  - \[x\] Fact Check
  - \[x\] Authentication
  - \[ \] Create claims
  - \[ \] Get created claims
  - \[ \] Delete created claims
  - \[ \] Edit claims

## Example

``` r
library(factcheck)

# Claims on Trump in English that are maximum 10 days old
fact_check("Trump", lang = "en-US", days_old = 10)
#> # A tibble: 24 x 4
#>    text                              claimant   claimDate     claimReview  
#>    <chr>                             <chr>      <chr>         <list>       
#>  1 "\"Many, many [auto] plants are … Donald Tr… 2019-06-18T0… <named list …
#>  2 "Quotes Gene Hackman as saying t… Facebook … 2019-06-20T0… <named list …
#>  3 "\"When I became president, Pres… Donald Tr… 2019-06-20T0… <named list …
#>  4 "A meme claims that a photo of a… Viral ima… 2019-06-17T0… <named list …
#>  5 "Claims that Sarah Huckabee Sand… Viral Ima… 2019-06-17T0… <named list …
#>  6 "“We are, by the way, the number… Donald Tr… 2019-06-18T0… <named list …
#>  7 "“We are, by the way, the number… Donald Tr… 2019-06-18T0… <named list …
#>  8 "\"Well, I got 52% (of women vot… Donald Tr… 2019-06-16T0… <named list …
#>  9 Allegedly shows a rally held by … Viral Ima… 2019-05-27T0… <named list …
#> 10 "Quotes Queen Elizabeth II as sa… Facebook … 2019-06-07T0… <named list …
#> # … with 14 more rows

# Claims made on the New York Times
fact_check(publisher = "nytimes.com")
#> # A tibble: 50 x 4
#>    text                             claimant    claimDate     claimReview  
#>    <chr>                            <chr>       <chr>         <list>       
#>  1 The F.B.I. never took the D.N.C… Donald Tru… 2001-07-16T0… <named list …
#>  2 Nobody’s been tougher on Russia… Donald Tru… 2019-06-18T0… <named list …
#>  3 We enacted “the biggest tax cut… Donald Tru… 2019-06-18T0… <named list …
#>  4 We have never taken in 10 cents… Donald Tru… 2019-06-18T0… <named list …
#>  5 Since the election, we have cre… Donald Tru… 2019-06-18T0… <named list …
#>  6 “We are building the wall. We w… Donald Tru… 2019-06-18T0… <named list …
#>  7 "Climate scientists are \"drive… Rick Santo… 2018-11-25T0… <named list …
#>  8 The U.S. has 52,000 troops in G… Donald Tru… 2018-07-13T0… <named list …
#>  9 Mr. Trump said Mrs. Clinton has… Donald J. … 2016-10-10T0… <named list …
#> 10 Mr. Trump said “a lot of car co… Donald J. … 2017-01-12T0… <named list …
#> # … with 40 more rows
```
