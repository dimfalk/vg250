#' Get bounding box information of the object queried from the dataset
#'
#' @param x character. Name of administrative area.
#' @param level character. Relevant administrative level.
#' @param crs character. Coordinate reference system definition.
#'
#' @return Geometry set of class `sfc_POLYGON`.
#' @export
#'
#' @examples
#' get_extent("Aachen")
#' get_extent("Aachen", crs = "epsg:25832")
#'
#' get_extent("Städteregion Aachen", level = "KRS")
get_extent <- function(x = NULL,
                       level = "GEM",
                       crs = "epsg:4326") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  if (level == "GEM") stopifnot("Name specified does not exist." = check_municipality(x))

  checkmate::assert_character(crs, len = 1, pattern = "epsg:[0-9]{4,6}")

  # ----------------------------------------------------------------------------

  bbox <- dplyr::filter(vg250, get(level) == x) |>
    sf::st_bbox() |>
    sf::st_as_sfc() |>
    sf::st_transform(crs)

  bbox
}
