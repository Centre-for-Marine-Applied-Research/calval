test_that("cv_create_log() will give an error if the event_id is not in
          the calval tracking sheet", {

  expect_error(cv_create_log(event_id = "val123"))
})
