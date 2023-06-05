#' Data: Polygon representation of administrative areas in Germany (VG250-EW 31.12.2021)
#'
#' VG250 product provided by the Federal Agency for Cartography and Geodesy, Germany
#'
#' @format Simple feature collection of type MULTIPOLYGON with 11,123 features and 4 fields:
#' \describe{
#'   \item{GEM}{municipality name, "GEM" level}
#'   \item{KRS}{district name, "KRS" level}
#'   \item{LAN}{state name, "LAN" level}
#'   \item{EWZ}{number of inhabitants}
#'   \item{geom}{coordinates}
#' }
#' @source <https://daten.gdz.bkg.bund.de/produkte/vg/vg250-ew_ebenen_1231/aktuell/vg250-ew_12-31.utm32s.shape.ebenen.zip>
#' @note Last access: 2023-06-05
#' @description <https://gdz.bkg.bund.de/index.php/default/verwaltungsgebiete-1-250-000-mit-einwohnerzahlen-stand-31-12-vg250-ew-31-12.html>
#' @note License: Data licence Germany – attribution – version 2.0
#' @note Copyright: GeoBasis-DE / BKG 2022 (modified)
"vg250"
