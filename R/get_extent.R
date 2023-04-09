#' Get bounding box information of the object queried from the dataset
#'
#' @param x character. Municipality name.
#' @param level character. Relevant administrative level.
#' @param as_bbox logical. Return bounding box as polygon or xmin/ymin/xmax/ymax?
#'
#' @return Geometry set of class `sfc_POLYGON` or extent of class `bbox`.
#' @export
#'
#' @examples
#' get_extent(x = "Aachen")
#' get_extent(x = "Städteregion Aachen", level = "KRS")
#'
#' get_extent(x = "Aachen", as_bbox = TRUE)
get_extent <- function(x = NULL,
                       level = "GEM",
                       as_bbox = FALSE) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  checkmate::assert_logical(as_bbox)

  # ----------------------------------------------------------------------------

  bbox <- dplyr::filter(vg250, get(level) == x) |>
    sf::st_bbox() |>
    sf::st_as_sfc()

  if (as_bbox == TRUE) {

    bbox <- sf::st_bbox(bbox)
  }

  bbox
}
