#' Get bounding box information of the object queried from the dataset
#'
#' @param x character. Name of administrative area.
#' @param level character. Relevant administrative level.
#' @param crs character. Spatial Reference System Identifier.
#' @param buffer numeric. Margin extension in meters.
#'     The buffer is applied to the bounding box, not the original geometry.
#'     Without buffering per default.
#'
#' @return Geometry set of class `sfc_POLYGON`.
#' @export
#'
#' @seealso [get_geometry()], [get_centroid()]
#'
#' @examples
#' get_extent("Aachen")
#' get_extent("Aachen", crs = "epsg:25832")
#'
#' get_extent("Städteregion Aachen", level = "KRS")
get_extent <- function(x = NULL,
                       level = "GEM",
                       crs = "epsg:4326",
                       buffer = 0) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  if (level == "GEM") stopifnot("Name specified does not exist." = is_municipality(x))

  checkmate::assert_character(crs, len = 1, pattern = "epsg:[0-9]{4,6}")

  checkmate::assert_numeric(buffer, len = 1, lower = 0, upper = 50000)

  # ----------------------------------------------------------------------------

  feat <- dplyr::filter(vg250, get(level) == x)

  n <- dim(feat)[1]

  # filter to presumably most relevant object, i.e. with the largest population
  if (level == "GEM" && n > 1) {

    feat <- dplyr::filter(feat, EWZ == max(EWZ))
  }

  bbox <- sf::st_bbox(feat) |>
    sf::st_as_sfc() |>
    sf::st_transform(crs)

  # eventually extend margins according to specification
  if (buffer > 0) {

    # NOTE: temporarily fixes an s2 related issue in dimfalk/vg250#14, see also r-spatial/sf#1692
    bbox <- sf::st_transform(bbox, "epsg:3034") |>
      sf::st_buffer(dist = buffer) |>
      sf::st_transform(crs)
  }

  bbox
}
