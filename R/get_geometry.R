#' Get original geometry information of the object queried from the dataset
#'
#' @param x character. Municipality name.
#' @param level character. Relevant administrative level.
#'
#' @return Geometry set of class `sfc_MULTIPOLYGON`.
#' @export
#'
#' @examples
#' get_geometry(x = "Aachen")
#' get_geometry(x = "Städteregion Aachen", level = "KRS")
get_geometry <- function(x = NULL,
                         level = "GEM") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  # ----------------------------------------------------------------------------

  geom <- dplyr::filter(vg250, get(level) == x) |>
    sf::st_union()

  geom
}
