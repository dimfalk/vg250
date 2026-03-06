test_that("Output type is as expected.", {

  expect_type(is_present("Aachen"), "logical")
})

test_that("Function working as intended.", {

  expect_equal(is_present("Aachen"), TRUE)

  expect_equal(is_present("Bonn"), TRUE)

  expect_equal(is_present("Freiburg im Breisgau"), TRUE)

  expect_equal(is_present("Aix La Chapelle"), FALSE)
})

test_that("Fallbacks working as intended.", {

  expect_equal(is_present("Roth") |> suppressWarnings(), TRUE)

  expect_equal(is_present("Freiburg") |> suppressWarnings(), FALSE)

  expect_warning(is_present("Roth"))

  expect_warning(is_present("Freiburg"))
})
