#' This function is a helper to make get requests to the API.
#'
#' @import httr
#' @import jsonlite
#' @include const.R
api_get <- function(path) {
  url <- httr::modify_url(API_BASE_URL(), path = path)

  resp <- GET(url)
  if (http_type(resp) != "application/json") {
    stop("API did not return json", call. = FALSE)
  }

  raw_content <- content(resp, "text", encoding = "UTF-8")
  parsed_content <- fromJSON(raw_content, simplifyVector = FALSE)

  if (http_error(resp)) {
    stop(
      sprintf(
        "API request failed [%s]\n%s\nIn case of trouble contact: <%s>",
        status_code(resp),
        parsed_content$detail,
        "mehdi.echel@gmail.com / mehdiechchelh.com"
      ),
      call. = FALSE
    )
  }

  structure(list(
    content = parsed_content,
    path = path,
    response = resp
  ),
  class = "eiopaR_api")

}
