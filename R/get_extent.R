#' Retrieve the bounding box information of the object queried from the dataset
#'
#' @param x character. Municipality name.
#' @param as_bbox logical. Return bounding box as polygon or xmin/ymin/xmax/ymax?
#'
#' @return Geometry set of class `sfc_POLYGON` or extent of class `bbox`.
#' @export
#'
#' @examples
#' get_extent("Aachen")
#' get_extent("Monschau", as_bbox = TRUE)
get_extent <- function(x = NULL,
                       as_bbox = FALSE) {

  bbox <- dplyr::filter(vg250_gem, GEN == x) |>
    sf::st_bbox() |>
    sf::st_as_sfc()

  if (as_bbox == TRUE) {

    bbox <- sf::st_bbox(bbox)
  }

  bbox
}
