#' Check whether given name of the administrative area is present in the dataset at the chosen level
#'
#' @param x character. Municipality name.
#' @param level character. Relevant administrative level.
#'
#' @return logical.
#' @export
#'
#' @examples
#' # municipalities
#' is_present("Aix la Chapelle")
#' is_present("Aachen")
#'
#' is_present("Roth")
#' is_present("Freiburg")
#'
#' # districts
#' is_present("Aachen", level = "KRS")
#' is_present("Städteregion Aachen", level = "KRS")
#'
#' # states
#' is_present("Westfalen", level = "LAN")
#' is_present("Nordrhein-Westfalen", level = "LAN")
is_present <- function(x = NULL,
                       level = "GEM") {

  # check arguments ------------------------------------------------------------

  checkmate::assert_character(x, len = 1)

  allowed_level <- c("GEM", "KRS", "LAN")

  checkmate::assert_choice(level, allowed_level)

  # main -----------------------------------------------------------------------

  # number of objects present
  if (level == "GEM") {

    n <- sum(vg250[[level]] == x, na.rm = TRUE)

  } else {

    n <- sum(unique(vg250[[level]]) == x, na.rm = TRUE)
  }

  # level-specific label for messages
  label <- switch(level,

                  GEM = "municipalities",
                  KRS = "districts",
                  LAN = "states")

  # no results, capture typos and non-existent names in the dataset
  if (n == 0) {

    # partial matching successful?
    partial <- vg250[[level]][grep(x, vg250[[level]])] |> unique()

    if (length(partial) > 0) {

      paste0("Your input did not return any objects. Are you looking for one of these ", label, "?") |>
        paste(x = _, stringr::str_c(partial, collapse = ", "), sep ="\n  ") |> warning()
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
