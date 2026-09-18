test_that("cv_c_summarise_flags() has correct dimensions", {
  expect_equal(nrow(dat_summary), 6)

  expect_equal(ncol(dat_summary), 5)

  expect_equal(
    unique(dat_summary$variable),
    c("dissolved_oxygen_percent_saturation", "temperature_degree_c")
  )
})
