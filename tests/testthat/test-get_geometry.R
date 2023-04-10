test_that("Output class is as expected.", {

  expect_s3_class(get_geometry(x = "Aachen"), c("sfc_MULTIPOLYGON", "sfc"))
})

test_that("Function working as intended.", {

  expect_equal(get_geometry(x = "Aachen") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.0571, 6.057, 6.0572, 6.0569, 6.0564, 6.0548, 6.0536, 6.0526, 6.0521, 6.0517))

  expect_equal(get_geometry(x = "Bonn") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.1272, 7.1253, 7.1246, 7.1239, 7.123, 7.1223, 7.1212, 7.1202, 7.1189, 7.1177))

  expect_equal(get_geometry(x = "Freiburg im Breisgau") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.8052, 7.8061, 7.8057, 7.8039, 7.8012, 7.7961, 7.7956, 7.7971, 7.7953, 7.7929))
})

test_that("LEVEL argument working as intended.", {

  expect_equal(get_geometry(x = "Städteregion Aachen", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(6.2379, 6.2378, 6.2377, 6.2379, 6.2382, 6.2387, 6.2392, 6.2395, 6.2388, 6.2386))

  expect_equal(get_geometry(x = "Rhein-Sieg-Kreis", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.1223, 7.124, 7.1206, 7.1092, 7.1062, 7.1053, 7.1037, 7.102, 7.0989, 7.0975))

  expect_equal(get_geometry(x = "Breisgau-Hochschwarzwald", level = "KRS") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(4),
               c(7.9834, 7.9843, 7.9916, 7.9963, 7.9996, 8.0039, 8.0057, 8.0076, 8.0098, 8.0126))
})

test_that("CRS argument working as intended.", {

  expect_equal(get_geometry(x = "Aachen", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(292867.3, 292863.2, 292886.1, 292864.1, 292833.8, 292724.7, 292637.2, 292563.6, 292527.3, 292498.6))

  expect_equal(get_geometry(x = "Bonn", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(367949.1, 367818.5, 367772.5, 367722.3, 367656.2, 367605.9, 367527.6, 367454.9, 367363.3, 367280.2))

  expect_equal(get_geometry(x = "Freiburg im Breisgau", crs = "epsg:25832") |> sf::st_coordinates() |> as.numeric() |> head(10) |> round(1),
               c(410985.1, 411051.8, 411018.4, 410880.5, 410683.6, 410297.8, 410259.9, 410371.1, 410230.8, 410048.8))
})

test_that("Fallbacks working as intended.", {

  expect_error(get_extent(x = "Aix La Chapelle"))

  expect_error(get_extent(x = "Freiburg") |> suppressWarnings())

  expect_warning(get_extent(x = "Roth"))
})
