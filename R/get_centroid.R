#' Get centroid of the object queried from the dataset
#'
#' @param x character. Name of administrative area.
#' @param level character. Relevant administrative level.
#' @param crs character. Spatial Reference System Identifier.
#'
#' @return Geometry set of class `sfc_POINT`.
#' @export
#'
#' @seealso [get_geometry()], [get_extent()]
#'
#' @examples
#' get_centroid("Aachen")
#' get_centroid("Aachen", crs = "epsg:25832")
#'
#' get_centroid("Städteregion Aachen", level = "KRS")
get_centroid <- function(x = NULL,
                         level = "GEM",
                         crs = "epsg:4326") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  stopifnot("Name specified does not exist." = is_present(x, level))

  checkmate::assert_character(crs, len = 1, pattern = "epsg:[0-9]{4,6}")

  # ----------------------------------------------------------------------------

  feat <- dplyr::filter(vg250, get(level) == x)

  n <- dim(feat)[1]

  if (level == "GEM" && n > 1) {

    feat <- dplyr::filter(feat, EWZ == max(EWZ))
  }

  p <- sf::st_union(feat) |>
    sf::st_centroid() |>
    sf::st_transform(crs)

  p
}
