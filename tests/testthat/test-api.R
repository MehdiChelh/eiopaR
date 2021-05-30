test_that("API online", {

  skip_if_offline("mehdiechchelh.com")
  skip_on_cran()

  resp <- api_get("/api/rfr/")
  expect_equal(resp$response$status_code, 200)
  expect_equal(resp$content, list(active = TRUE))
})
