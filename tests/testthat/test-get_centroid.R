test_that("Output class is as expected.", {

  expect_s3_class(get_centroid("Aachen"), c("sfc_POINT", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_centroid("Aachen") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(6.1090, 50.7605))

  expect_equal(get_centroid("Bonn") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.1098, 50.7058))

  expect_equal(get_centroid("Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.8181, 47.9927))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_centroid("Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(6.2170, 50.7280))

  expect_equal(get_centroid("Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.2342, 50.7607))

  expect_equal(get_centroid("Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> round(4),
               c(7.9251, 47.9250))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_centroid("Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(296114.6, 5627180.8))

  expect_equal(get_centroid("Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(366536.3, 5618811.7))

  expect_equal(get_centroid("Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> round(1),
               c(411822.3, 5316159.3))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_centroid("Aix La Chapelle"))

  expect_error(get_centroid("Freiburg") |> suppressWarnings())

  expect_warning(get_centroid("Roth"))
})
