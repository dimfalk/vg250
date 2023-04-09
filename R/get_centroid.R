#' Get centroid of the object queried from the dataset
#'
#' @param x character. Municipality name.
#' @param level character. Relevant administrative level.
#' @param crs character. Coordinate reference system definition.
#'
#' @return Geometry set of class `sfc_POINT`.
#' @export
#'
#' @examples
#' get_centroid(x = "Aachen")
#' get_centroid(x = "Aachen", crs = "epsg:25832")
#'
#' get_centroid(x = "Städteregion Aachen", level = "KRS")
get_centroid <- function(x = NULL,
                         level = "GEM",
                         crs = "epsg:4326") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  # ----------------------------------------------------------------------------

  p <- dplyr::filter(vg250, get(level) == x) |>
    sf::st_union() |>
    sf::st_centroid() |>
    sf::st_transform(crs)

  p
}
