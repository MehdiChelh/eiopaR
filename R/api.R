#' This function is a helper to make get requests to the API.
#'
#' @param path the path to an endpoint of the API
#' @return A list of class "eiopaR_api". It has at least the following components:
#' \describe{
#'   \item{content}{the JSON content parsed to a list.}
#'   \item{path}{the path to the requested endpoint.}
#'   \item{response}{the raw response.}
#' }
#' @import httr
#' @importFrom curl has_internet
#' @import jsonlite
#' @include const.R
api_get <- function(path) {
  url <- modify_url(API_BASE_URL(), path = path)

  # First check internet connection
  if (!has_internet()) {
    message("No internet connection.")
    return(invisible(NULL))
  }

  resp <- try_GET(url)

  is_response <- function(x) {
    class(x) == "response"
  }

  # Then try for timeout problems
  if (!is_response(resp)) {
    message(resp)
    return(invisible(NULL))
  }
  # Then stop if status > 400
  if (http_error(resp)) {
    message_for_status(resp)
    return(invisible(NULL))
  }

  if (http_type(resp) != "application/json") {
    message("API did not return json", call. = FALSE)
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


#' Wrapper for GET requests
#' @param x the url to request
#' @param ... additional parameters passed to the GET function.
#' @return The result of the GET request.
try_GET <- function(x, ...) {
  tryCatch(
    GET(url = x, timeout(2), ...),
    error = function(e) conditionMessage(e),
    warning = function(w) conditionMessage(w)
  )
}
