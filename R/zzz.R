.onAttach <- function(libname, pkgname) {

  pkg <- "vg250"

  utils::packageVersion(pkg) |> packageStartupMessage()
}

#' @import sf
NULL
