test_that("Output class is as expected.", {

  expect_s3_class(get_geometry("Aachen"), c("sfc_POLYGON", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_geometry("Aachen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.0571, 6.057, 6.0572, 6.0569, 6.0564, 6.0548, 6.0536, 6.0526, 6.0521, 6.0517))

  expect_equal(get_geometry("Bonn") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.1272, 7.1253, 7.1246, 7.1239, 7.123, 7.1223, 7.1212, 7.1202, 7.1189, 7.1177))

  expect_equal(get_geometry("Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.8052, 7.8061, 7.8057, 7.8039, 7.8012, 7.7961, 7.7956, 7.7971, 7.7953, 7.7929))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_geometry("Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.2049, 6.2046, 6.2042, 6.2037, 6.2028, 6.2017, 6.2004, 6.1988, 6.198, 6.1973))

  expect_equal(get_geometry("Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.1223, 7.124, 7.1206, 7.1092, 7.1062, 7.1053, 7.1037, 7.102, 7.0989, 7.0975))

  expect_equal(get_geometry("Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.9834, 7.9843, 7.9916, 7.9963, 7.9996, 8.0039, 8.0057, 8.0076, 8.0098, 8.0126))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_geometry("Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(292867.3, 292863.2, 292886.1, 292864.1, 292833.8, 292724.7, 292637.2, 292563.6, 292527.3, 292498.6))

  expect_equal(get_geometry("Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(367949.1, 367818.5, 367772.5, 367722.3, 367656.2, 367605.9, 367527.6, 367454.9, 367363.3, 367280.2))

  expect_equal(get_geometry("Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(410985.1, 411051.8, 411018.4, 410880.5, 410683.6, 410297.8, 410259.9, 410371.1, 410230.8, 410048.8))
})

test_that("In case of non-unique GEM names, geometry with largest number of inhabitants is returned.", {

  expect_equal(get_geometry("Neuenkirchen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(7.3784, 7.3669, 7.3657, 7.3656, 7.3616, 7.351, 7.3456, 7.337, 7.3295, 7.3295))

  expect_equal(get_geometry("Schönberg") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(10.9784, 10.9766, 10.9756, 10.9747, 10.9733, 10.9715, 10.9695, 10.9693, 10.9688, 10.9685))

  expect_equal(get_geometry("Berg") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4) |> suppressWarnings(),
               c(11.4097, 11.4098, 11.4054, 11.4026, 11.4005, 11.399, 11.3989, 11.3994, 11.3989, 11.3993))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_extent("Aix La Chapelle"))

  expect_error(get_extent("Freiburg") |> suppressWarnings())

  expect_warning(get_extent("Roth"))
})
