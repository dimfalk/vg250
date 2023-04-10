test_that("Output type is as expected.", {

  expect_type(check_municipality(x = "Aachen"), "logical")
})

test_that("CRS argument working as intended.", {

  expect_equal(check_municipality(x = "Aachen"), TRUE)

  expect_equal(check_municipality(x = "Bonn"), TRUE)

  expect_equal(check_municipality(x = "Freiburg im Breisgau"), TRUE)
})

test_that("Fallbacks working as intended.", {

  expect_equal(check_municipality(x = "Aix La Chapelle"), FALSE)

  expect_equal(check_municipality(x = "Freiburg") |> suppressWarnings(), FALSE)

  expect_warning(check_municipality(x = "Freiburg"))

  expect_equal(check_municipality(x = "Roth") |> suppressWarnings(), TRUE)

  expect_warning(check_municipality(x = "Roth"))
})
