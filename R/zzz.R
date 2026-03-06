.onAttach <- function(libname, pkgname) {

  utils::packageVersion(pkgname) |> packageStartupMessage()
}

#' @import sf
NULL
