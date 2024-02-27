#' Check whether given municipality name is present in vg250 dataset
#'
#' @param x character. Municipality name.
#'
#' @return logical.
#' @noRd
#'
#' @import sf
#'
#' @examples
#' \dontrun{
#' check_municipality("Aachen")
#' check_municipality("Roth")
#'
#' check_municipality("Aix la Chapelle")
#' check_municipality("Freiburg")
#' }
check_municipality <- function(x = NULL) {

  # debugging ------------------------------------------------------------------

  # x <- "Aachen"

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  # main -----------------------------------------------------------------------

  sf <- dplyr::filter(vg250, GEM == x)

  # number of objects present
  n <- dim(sf)[1]

  # no results, capture typos and non-existent names in the dataset
  if (n == 0) {

    # partial matching successful?
    pmatch <- vg250[["GEM"]][grep(x, vg250[["GEM"]])]

    if (length(pmatch) > 0) {

      paste("Your input did not return any objects. Are you looking for one of these municipalities?",
            stringr::str_c(pmatch, collapse = ", "), sep ="\n  ") |> warning()
    }

    FALSE

    # do nothing when the (desired) object was found exactly once
  } else if (n == 1) {

    TRUE

    # multiple results, warn user in case the name provided was not unique
  } else if (n > 1) {

    paste("Your input returned multiple objects. Only the object with the largest number of inhabitants is processed.",
          "Consider to visually inspect the returned object using e.g. `mapview::mapview()`.", sep ="\n  ") |> warning()

    TRUE
  }
}
