#' Retrieve centroid of the object queried from the dataset
#'
#' @param x character. Municipality name.
#'
#' @return Geometry set of class `sfc_POINT`.
#' @export
#'
#' @examples
#' get_centroid("Aachen")
get_centroid <- function(x = NULL) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  # ----------------------------------------------------------------------------

  dplyr::filter(vg250_gem, GEN == x) |>
    sf::st_centroid() |>
    sf::st_geometry()
}
