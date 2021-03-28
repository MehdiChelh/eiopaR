test_that("API online", {
  resp <- api_get("/api/rfr/")
  expect_equal(resp$response$status_code, 200)
  expect_equal(resp$content, list(active = TRUE))
})
