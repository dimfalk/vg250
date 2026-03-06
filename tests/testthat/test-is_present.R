test_that("Output type is as expected.", {

  expect_type(is_present("Aachen"), "logical")
})

test_that("CRS argument working as intended.", {

  expect_equal(is_present("Aachen"), TRUE)

  expect_equal(is_present("Bonn"), TRUE)

  expect_equal(is_present("Freiburg im Breisgau"), TRUE)
})

test_that("Fallbacks working as intended.", {

  expect_equal(is_present("Aix La Chapelle"), FALSE)

  expect_equal(is_present("Freiburg") |> suppressWarnings(), FALSE)

  expect_warning(is_present("Freiburg"))

  expect_equal(is_present("Roth") |> suppressWarnings(), TRUE)

  expect_warning(is_present("Roth"))
})
