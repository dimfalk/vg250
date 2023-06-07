#' Get original geometry information of the object queried from the dataset
#'
#' @param x character. Name of administrative area.
#' @param level character. Relevant administrative level.
#' @param crs character. Coordinate reference system definition.
#'
#' @return Geometry set of class `sfc_MULTIPOLYGON`.
#' @export
#'
#' @examples
#' get_geometry("Aachen")
#' get_geometry("Aachen", crs = "epsg:25832")
#'
#' get_geometry("Städteregion Aachen", level = "KRS")
get_geometry <- function(x = NULL,
                         level = "GEM",
                         crs = "epsg:4326") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  if (level == "GEM") stopifnot("Name specified does not exist." = check_municipality(x))

  checkmate::assert_character(crs, len = 1, pattern = "epsg:[0-9]{4,6}")

  # ----------------------------------------------------------------------------

  sf <- dplyr::filter(vg250, get(level) == x)

  n <- dim(sf)[1]

  if (level == "GEM" && n > 1) {

    sf <- dplyr::filter(sf, EWZ == max(EWZ))
  }

  geom <- sf::st_union(sf) |>
    sf::st_transform(crs)

  geom
}
