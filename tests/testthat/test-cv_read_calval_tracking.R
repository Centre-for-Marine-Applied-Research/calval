test_that("calval_tracking has correct number of columns", {
  expect_equal(ncol(calval_tracking), 15)
})

test_that("deployment_can and retrieval_can are assigned correct tzone", {
  expect_equal(
    lubridate::tz(calval_tracking$deployment_ast),
    "America/Halifax"
  )

  expect_equal(
    lubridate::tz(calval_tracking$retrieval_ast),
    "America/Halifax"
  )
})

# test_that("deployment_utc and retrieval_utc are assigned correct tzone", {
#   expect_equal(lubridate::tz(calval_tracking$deployment_utc), "UTC")
#
#   expect_equal(lubridate::tz(calval_tracking$retrieval_utc),"UTC")
# })

test_that("wrong sheet name generates an error", {
  expect_error(cv_read_calval_tracking(sheet = "err"))
})
