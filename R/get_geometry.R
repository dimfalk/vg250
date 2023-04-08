#' Retrieve the original geometry information of the object queried from the dataset
#'
#' @param x character. Municipality name.
#'
#' @return Geometry set of class `sfc_MULTIPOLYGON`.
#' @export
#'
#' @examples
#' get_geometry("Aachen")
get_geometry <- function(x = NULL) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  # ----------------------------------------------------------------------------

  geom <- dplyr::filter(vg250_gem, GEN == x) |>
    sf::st_geometry()

  geom
}
