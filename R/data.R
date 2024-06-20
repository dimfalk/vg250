#' Data: Polygon representation of administrative areas in Germany (VG250-EW 31.12.2022)
#'
#' VG250 product provided by the Federal Agency for Cartography and Geodesy, Germany
#'
#' @format Simple feature collection of type MULTIPOLYGON with 10,990 features and 6 fields:
#' \describe{
#'   \item{GEM}{character. Municipality name, 'GEM' level.}
#'   \item{KRS}{character. District name, 'KRS' level.}
#'   \item{LAN}{character. State name, 'LAN' level.}
#'   \item{EWZ}{integer. Number of inhabitants according to census bureau \code{[-]}.}
#'   \item{KFL}{numeric. Area according to real estate cadastre \code{[km2]}.}
#'
#'   \item{geom}{sfc_GEOMETRY. Coordinates.}
#' }
#' @source <https://daten.gdz.bkg.bund.de/produkte/vg/vg250-ew_ebenen_1231/aktuell/vg250-ew_12-31.utm32s.shape.ebenen.zip>
#' @note Last access: 2024-06-20
#' @description <https://gdz.bkg.bund.de/index.php/default/verwaltungsgebiete-1-250-000-mit-einwohnerzahlen-stand-31-12-vg250-ew-31-12.html>
#' @note License: Data licence Germany – attribution – version 2.0
#' @note Copyright: GeoBasis-DE / BKG 2024 (modified)
"vg250"
