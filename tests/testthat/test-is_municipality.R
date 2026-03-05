test_that("Output type is as expected.", {

  expect_type(is_municipality("Aachen"), "logical")
})

test_that("CRS argument working as intended.", {

  expect_equal(is_municipality("Aachen"), TRUE)

  expect_equal(is_municipality("Bonn"), TRUE)

  expect_equal(is_municipality("Freiburg im Breisgau"), TRUE)
})

test_that("Fallbacks working as intended.", {

  expect_equal(is_municipality("Aix La Chapelle"), FALSE)

  expect_equal(is_municipality("Freiburg") |> suppressWarnings(), FALSE)

  expect_warning(is_municipality("Freiburg"))

  expect_equal(is_municipality("Roth") |> suppressWarnings(), TRUE)

  expect_warning(is_municipality("Roth"))
})
