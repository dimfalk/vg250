
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vg250

<!-- badges: start -->

[![R-CMD-check](https://github.com/dimfalk/vg250/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/dimfalk/vg250/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/dimfalk/vg250/branch/main/graph/badge.svg)](https://codecov.io/gh/dimfalk/vg250)
<!-- badges: end -->

vg250 is a helper package to provide access to VG250 dataset in order to
derive spatial information for a chosen administrative level for various
applications.

Since I found myself in the need of some kind of spatial information on
a municipality level for convenience reasons quite often, the decision
was made to centralize associated data and functions based on `{sf}` in
a separate package to simplify maintenance.

## Installation

You can install the development version of vg250 from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("dimfalk/vg250")
```

## Basic examples

Just a few quick insights on the use of this package:

``` r
library(vg250)

# fetch data
geom <- get_geometry("Aachen")
e <- get_extent("Aachen")
p <- get_centroid("Aachen")

# check classes
class(geom)
#> [1] "sfc_MULTIPOLYGON" "sfc"
class(e)
#> [1] "sfc_POLYGON" "sfc"
class(p)
#> [1] "sfc_POINT" "sfc"

# inspect visually
library(ggplot2)

ggplot() + 
  geom_sf(data = e) + 
  geom_sf(data = geom, col = "red") + 
  geom_sf(data = p, col = "blue")
```

<img src="man/figures/README-example-1.png" width="100%" />

This information can now be used to e.g. create masks to crop raster
data, select vector features, perform spatial joins, construct API
calls, etc.

``` r
# convert to SpatExtent object when working with `{terra}`
terra::vect(e) |> terra::ext()
#> SpatExtent : 5.9748614, 6.2169125, 50.6488647, 50.8573535 (xmin, xmax, ymin, ymax)

# select vector features by p
sf::st_filter(vg250, p)
#> Simple feature collection with 1 feature and 3 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 5.974861 ymin: 50.64886 xmax: 6.216912 ymax: 50.85735
#> Geodetic CRS:  WGS 84
#>      GEM                 KRS                 LAN                           geom
#> 1 Aachen Städteregion Aachen Nordrhein-Westfalen MULTIPOLYGON (((6.057066 50...

# join attributes spatially to p
sf::st_intersection(vg250, p)
#> Simple feature collection with 1 feature and 3 fields
#> Geometry type: POINT
#> Dimension:     XY
#> Bounding box:  xmin: 6.109715 ymin: 50.75954 xmax: 6.109715 ymax: 50.75954
#> Geodetic CRS:  WGS 84
#>         GEM                 KRS                 LAN                      geom
#> 2145 Aachen Städteregion Aachen Nordrhein-Westfalen POINT (6.109715 50.75954)

# construct API queries
sf::st_bbox(e) |> as.numeric() |> round(4) |> paste0(collapse = ",") |> paste0("&bbox=", x = _)
#> [1] "&bbox=5.9749,50.6489,6.2169,50.8574"
```

Note: The VG250 dataset itself can be accessed via `vg250`:

``` r
vg250
#> Simple feature collection with 11123 features and 3 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 5.86625 ymin: 47.27012 xmax: 15.04182 ymax: 55.05878
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>                    GEM          KRS                LAN
#> 1            Flensburg    Flensburg Schleswig-Holstein
#> 2                 Kiel         Kiel Schleswig-Holstein
#> 3               Lübeck       Lübeck Schleswig-Holstein
#> 4           Neumünster   Neumünster Schleswig-Holstein
#> 5          Brunsbüttel Dithmarschen Schleswig-Holstein
#> 6                Heide Dithmarschen Schleswig-Holstein
#> 7              Averlak Dithmarschen Schleswig-Holstein
#> 8             Brickeln Dithmarschen Schleswig-Holstein
#> 9             Buchholz Dithmarschen Schleswig-Holstein
#> 10 Burg (Dithmarschen) Dithmarschen Schleswig-Holstein
#>                              geom
#> 1  MULTIPOLYGON (((9.412137 54...
#> 2  MULTIPOLYGON (((10.16852 54...
#> 3  MULTIPOLYGON (((10.87526 53...
#> 4  MULTIPOLYGON (((9.991971 54...
#> 5  MULTIPOLYGON (((9.166074 53...
#> 6  MULTIPOLYGON (((9.121658 54...
#> 7  MULTIPOLYGON (((9.212443 53...
#> 8  MULTIPOLYGON (((9.255627 54...
#> 9  MULTIPOLYGON (((9.182763 53...
#> 10 MULTIPOLYGON (((9.277097 54...
```
