test_that("Output class is as expected.", {

  expect_s3_class(get_centroid(x = "Aachen"), c("sfc_POINT", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_centroid(x = "Aachen") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(6.1097, 50.7595))

  expect_equal(get_centroid(x = "Bonn") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.1099, 50.7058))

  expect_equal(get_centroid(x = "Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.8181, 47.9927))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_centroid(x = "Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(6.217, 50.728))

  expect_equal(get_centroid(x = "Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.2342, 50.7607))

  expect_equal(get_centroid(x = "Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.9251, 47.925))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_centroid(x = "Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(296160.6, 5627069.2))

  expect_equal(get_centroid(x = "Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(366537.5, 5618810.5))

  expect_equal(get_centroid(x = "Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(411822.3, 5316159.6))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_centroid(x = "Aix La Chapelle"))

  expect_error(get_centroid(x = "Freiburg") |> suppressWarnings())

  expect_warning(get_centroid(x = "Roth"))
})
