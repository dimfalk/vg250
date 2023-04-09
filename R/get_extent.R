#' Get bounding box information of the object queried from the dataset
#'
#' @param x character. Municipality name.
#' @param level character. Relevant administrative level.
#' @param crs character. Coordinate reference system definition.
#'
#' @return Geometry set of class `sfc_POLYGON`.
#' @export
#'
#' @examples
#' get_extent(x = "Aachen")
#' get_extent(x = "Aachen", crs = "epsg:25832")
#'
#' get_extent(x = "Städteregion Aachen", level = "KRS")
get_extent <- function(x = NULL,
                       level = "GEM",
                       crs = "epsg:4326") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  # ----------------------------------------------------------------------------

  bbox <- dplyr::filter(vg250, get(level) == x) |>
    sf::st_bbox() |>
    sf::st_as_sfc() |>
    sf::st_transform(crs)

  bbox
}
