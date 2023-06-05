## code to prepare `vg250` dataset goes here

file <- "vg250-ew_12-31.utm32s.shape.ebenen.zip"

base_url <- paste0("https://daten.gdz.bkg.bund.de/produkte/vg/vg250-ew_ebenen_1231/aktuell/", file)

utils::download.file(base_url, file)

utils::unzip(file)

unlink(file)

# read data --------------------------------------------------------------------

gem <- list.files(pattern = "VG250_GEM.shp", full.names = TRUE, recursive = TRUE)
krs <- list.files(pattern = "VG250_KRS.shp", full.names = TRUE, recursive = TRUE)
lan <- list.files(pattern = "VG250_LAN.shp", full.names = TRUE, recursive = TRUE)

vg250_gem <- sf::read_sf(gem) |> dplyr::select("GEN", "EWZ", "KFL")

vg250_krs <- sf::read_sf(krs) |> dplyr::select("GEN")

vg250_lan <- sf::read_sf(lan) |> dplyr::select("GEN")

# processing -------------------------------------------------------------------

vg250_gemkrs <- sf::st_join(sf::st_centroid(vg250_gem), vg250_krs)

vg250_gemkrslan <- sf::st_join(sf::st_centroid(vg250_gemkrs), vg250_lan)

geom <- sf::st_geometry(vg250_gem)

atab <- sf::st_drop_geometry(vg250_gemkrslan) |>
  dplyr::rename("GEM" = "GEN.x",
                "KRS" = "GEN.y",
                "LAN" = "GEN") |>
  dplyr::select("GEM", "KRS", "LAN", "EWZ", "KFL")

vg250 <- sf::st_as_sf(atab, geom) |>
  dplyr::filter(KFL > 0) |>
  sf::st_transform("epsg:4326") |>
  sf::st_make_valid()

# write to disk ----------------------------------------------------------------

usethis::use_data(vg250, overwrite = TRUE)

unlink(stringr::str_sub(file, 1, -5), recursive = TRUE)
