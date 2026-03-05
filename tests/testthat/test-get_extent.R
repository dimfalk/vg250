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
               c(5.9602, 5.9602, 5.9602, 5.9602, 5.9603, 5.9605, 5.9607, 5.9609, 5.9611, 5.9614))

  expect_equal(get_extent("Bonn", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.0088, 7.0088, 7.0088, 7.0089, 7.009, 7.0091, 7.0093, 7.0095, 7.0098, 7.0101))

  expect_equal(get_extent("Freiburg im Breisgau", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.6486, 7.6486, 7.6486, 7.6487, 7.6487, 7.6489, 7.649, 7.6493, 7.6495, 7.6498))



  expect_equal(get_extent("Aachen", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(285176.8, 286062.1, 286065.8, 286072.2, 286081.5, 286093.5, 286108.3, 286125.8, 286145.9, 286168.7))

  expect_equal(get_extent("Bonn", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(359184.6, 359607.9, 359610.8, 359616.4, 359624.9, 359636.2, 359650.3, 359667, 359686.4, 359708.5))

  expect_equal(get_extent("Freiburg im Breisgau", crs = "epsg:25832", buffer = 1000) |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(399006.3, 399329.3, 399331.7, 399336.9, 399344.8, 399355.6, 399369.1, 399385.4, 399404.3, 399425.8))
})

test_that("In case of non-unique GEM names, geometry with largest number of inhabitants is returned.", {

  expect_equal(get_extent("Neuenkirchen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(7.3244, 7.4451, 7.4451, 7.3244, 7.3244, 52.1802, 52.1802, 52.2935, 52.2935, 52.1802))

  expect_equal(get_extent("Schönberg") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(10.8273, 10.9994, 10.9994, 10.8273, 10.8273, 53.8141, 53.8141, 53.8936, 53.8936, 53.8141))

  expect_equal(get_extent("Berg") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(11.334, 11.4289, 11.4289, 11.334, 11.334, 47.9196, 47.9196, 48, 48, 47.9196))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_extent("Aix La Chapelle"))

  expect_error(get_extent("Freiburg") |> suppressWarnings())

  expect_warning(get_extent("Roth"))
})
