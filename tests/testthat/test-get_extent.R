test_that("Output class is as expected.", {

  expect_s3_class(get_extent(x = "Aachen"), c("sfc_POLYGON", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_extent(x = "Aachen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(5.9749, 6.2169, 6.2169, 5.9749, 5.9749, 50.6489, 50.6489, 50.8574, 50.8574, 50.6489))

  expect_equal(get_extent(x = "Bonn") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.0235, 7.2109, 7.2109, 7.0235, 7.0235, 50.6319, 50.6319, 50.7744, 50.7744, 50.6319))

  expect_equal(get_extent(x = "Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.6625, 7.9303, 7.9303, 7.6625, 7.6625, 47.9035, 47.9035, 48.0711, 48.0711, 47.9035))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_extent(x = "Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(5.9749, 6.4197, 6.4197, 5.9749, 5.9749, 50.4944, 50.4944, 50.9501, 50.9501, 50.4944))

  expect_equal(get_extent(x = "Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.8543, 7.6822, 7.6822, 6.8543, 6.8543, 50.5559, 50.5559, 50.9498, 50.9498, 50.5559))

  expect_equal(get_extent(x = "Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.5297, 8.4397, 8.4397, 7.5297, 7.5297, 47.7436, 47.7436, 48.1168, 48.1168, 47.7436))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_extent(x = "Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(286148.5, 303256.7, 304129.3, 287097, 286148.5, 5615145.9, 5614474.8, 5637653.1, 5638323.2, 5615145.9))

  expect_equal(get_extent(x = "Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(360219.6, 373470.8, 373854, 360643, 360219.6, 5610752.5, 5610415.8, 5626267.7, 5626604.1, 5610752.5))

  expect_equal(get_extent(x = "Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(400040.1, 420058, 420316.5, 400363.3, 400040.1, 5306440.6, 5306128.5, 5324757.5, 5325069.4, 5306440.6))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_extent(x = "Aix La Chapelle"))

  expect_error(get_extent(x = "Freiburg") |> suppressWarnings())

  expect_warning(get_extent(x = "Roth"))
})
