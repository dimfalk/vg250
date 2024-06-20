test_that("Output class is as expected.", {

  expect_s3_class(get_extent("Aachen"), c("sfc_POLYGON", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_extent("Aachen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(5.9749, 6.2169, 6.2169, 5.9749, 5.9749, 50.6628, 50.6628, 50.8574, 50.8574, 50.6628))

  expect_equal(get_extent("Bonn") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.0235, 7.2107, 7.2107, 7.0235, 7.0235, 50.6319, 50.6319, 50.7744, 50.7744, 50.6319))

  expect_equal(get_extent("Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.6625, 7.9303, 7.9303, 7.6625, 7.6625, 47.9035, 47.9035, 48.0711, 48.0711, 47.9035))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_extent("Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(5.9749, 6.4197, 6.4197, 5.9749, 5.9749, 50.4944, 50.4944, 50.9501, 50.9501, 50.4944))

  expect_equal(get_extent("Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.8543, 7.6822, 7.6822, 6.8543, 6.8543, 50.5559, 50.5559, 50.9498, 50.9498, 50.5559))

  expect_equal(get_extent("Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.5297, 8.4397, 8.4397, 7.5297, 7.5297, 47.7436, 47.7436, 48.1168, 48.1168, 47.7436))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_extent("Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(286211.7, 303314.9, 304129.3, 287097, 286211.7, 5616693.9, 5616022.8, 5637653.1, 5638323.2, 5616693.9))

  expect_equal(get_extent("Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(360219.6, 373460.2, 373843.4, 360643, 360219.6, 5610752.5, 5610416, 5626268, 5626604.1, 5610752.5))

  expect_equal(get_extent("Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(400040.1, 420058, 420316.5, 400363.3, 400040.1, 5306440.6, 5306128.5, 5324757.5, 5325069.4, 5306440.6))
})

test_that("BUFFER argument working as intended.", {

  expect_equal(get_extent("Aachen", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(5.9607, 5.9607, 5.9607, 5.9607, 5.9608, 5.961, 5.9611, 5.9614, 5.9616, 5.9619))

  expect_equal(get_extent("Bonn", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.0094, 7.0093, 7.0093, 7.0094, 7.0095, 7.0096, 7.0098, 7.0100, 7.0102, 7.0105))

  expect_equal(get_extent("Freiburg im Breisgau", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.6491, 7.649, 7.6491, 7.6491, 7.6492, 7.6493, 7.6495, 7.6497, 7.6499, 7.6502))



  expect_equal(get_extent("Aachen", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(285212.6, 286097.9, 286101.4, 286107.6, 286116.5, 286128.2, 286142.4, 286159.3, 286178.8, 286200.7))

  expect_equal(get_extent("Bonn", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(359220, 359643.3, 359646.1, 359651.6, 359659.8, 359670.7, 359684.2, 359700.4, 359719.2, 359740.5))

  expect_equal(get_extent("Freiburg im Breisgau", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(399040.3, 399363.5, 399365.7, 399370.7, 399378.5, 399388.9, 399401.9, 399417.6, 399435.9, 399456.8))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_extent("Aix La Chapelle"))

  expect_error(get_extent("Freiburg") |> suppressWarnings())

  expect_warning(get_extent("Roth"))
})
