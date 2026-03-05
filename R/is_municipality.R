#' Check whether given municipality name is present in vg250 dataset
#'
#' @param x character. Municipality name.
#'
#' @return logical.
#' @export
#'
#' @examples
#' \dontrun{
#' is_municipality("Aachen")
#' is_municipality("Aix la Chapelle")
#'
#' is_municipality("Roth")
#' is_municipality("Freiburg")
#' }
is_municipality <- function(x = NULL) {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  # main -----------------------------------------------------------------------

  # number of objects present
  n <- sum(vg250[["GEM"]] == x, na.rm = TRUE)

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
