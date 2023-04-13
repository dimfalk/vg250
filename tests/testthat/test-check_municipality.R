test_that("Output type is as expected.", {

  expect_type(check_municipality("Aachen"), "logical")
})

test_that("CRS argument working as intended.", {

  expect_equal(check_municipality("Aachen"), TRUE)

  expect_equal(check_municipality("Bonn"), TRUE)

  expect_equal(check_municipality("Freiburg im Breisgau"), TRUE)
})

test_that("Fallbacks working as intended.", {

  expect_equal(check_municipality("Aix La Chapelle"), FALSE)

  expect_equal(check_municipality("Freiburg") |> suppressWarnings(), FALSE)

  expect_warning(check_municipality("Freiburg"))

  expect_equal(check_municipality("Roth") |> suppressWarnings(), TRUE)

  expect_warning(check_municipality("Roth"))
})
