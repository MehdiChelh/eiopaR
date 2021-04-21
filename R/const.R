#' Base URL to the API.
#' @return A string: the base URL to the API.
API_BASE_URL <- function() {
  "https://mehdiechchelh.com/api/rfr/"
}


#' Build path to the RFR (risk-free rate) endpoint.
#' @param type one of the types available by the API (see `options_rfr_types()`)
#' @param region one of the regions available by the API (see `get_options("region")`)
#' @param params additional GET parameters
#' @return A string: the path to the RFR endpoint.
PATH_GET_RFR <- function(type, region, params) {
  sprintf("/api/rfr/%s/%s/?%s",
          type,
          region,
          paste(names(params), params, sep = "=", collapse = "&"))
}


#' Build path to the options endpoint.
#' @param field the field name for the endpoint giving the available options
#' @return A string: the path to the options endpoint.
PATH_GET_OPTIONS <- function(field) {
  sprintf("/api/rfr/options/%s", field)
}


# Type of the risk-free-rate to query
WITH_VA <- function() {"with_va"}
NO_VA <- function() {"no_va"}
NO_VA_SHOCK_DOWN <- function() {"no_va_shock_down"}
NO_VA_SHOCK_UP <- function() {"no_va_shock_up"}
WITH_VA_SHOCK_DOWN <- function() {"with_va_shock_down"}
WITH_VA_SHOCK_UP <- function() {"with_va_shock_down"}
VA <- function() {"va"}

#' @title Available curves
#' @description This function returns a list of the available options for the risk-free-rates curves.
#' (see argument "type" for `get_rfr`)
#' @return vector of strings: the different options available.
#' @example options_rfr_types()
#' @seealso get_rfr
#' @export
options_rfr_types <- function(){
  c(WITH_VA(),
    NO_VA(),
    NO_VA_SHOCK_DOWN(),
    NO_VA_SHOCK_UP(),
    WITH_VA_SHOCK_DOWN(),
    WITH_VA_SHOCK_UP(),
    VA())
}
