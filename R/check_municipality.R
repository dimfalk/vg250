#' Check whether given municipality name is present in vg250 dataset
#'
#' @param x character. Municipality name.
#'
#' @return logical.
#' @export
#'
#' @import sf
#'
#' @examples
#' check_municipality(x = "Aachen")
#' check_municipality(x = "Roth")
#'
#' check_municipality(x = "Aix la Chapelle")
#' check_municipality(x = "Freiburg")
check_municipality <- function(x = NULL) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  # main -----------------------------------------------------------------------

  sf <- dplyr::filter(vg250, GEM == x)

  # number of objects present
  n <- dim(sf)[1]

  # do nothing in case of one hit
  if (n == 1) {

    TRUE

    # capture typos and non-existent names in the dataset
  } else if (n == 0) {

    # partial matching successful?
    pmatch <- vg250[["GEM"]][grep(x, vg250[["GEM"]])]

    if (length(pmatch) > 0) {

      paste("Did you mean one of the following entries?",
            stringr::str_c(pmatch, collapse = ", "), sep ="\n  ") |> warning()
    }

    FALSE

    # warn user in case the name provided was not unique with multiple results
  } else if (n > 1) {

    paste("The name provided returned multiple results.",
          "Consider to visually inspect the returned object using e.g. `mapview::mapview()`.", sep ="\n  ") |> warning()

    TRUE
  }
}
