## code to prepare `vg250_gem` dataset goes here

file <- "vg250_12-31.utm32s.shape.ebenen.zip"

base_url <- paste0("https://daten.gdz.bkg.bund.de/produkte/vg/vg250_ebenen_1231/aktuell/", file)

utils::download.file(base_url, file)

utils::unzip(file)

unlink(file)

shp <- list.files(pattern = "VG250_GEM.shp", full.names = TRUE, recursive = TRUE)

vg250_gem <- sf::read_sf(shp) |>
  sf::st_transform("epsg:4326")

usethis::use_data(vg250_gem, overwrite = TRUE)

unlink(stringr::str_sub(file, 1, -5), recursive = TRUE)
