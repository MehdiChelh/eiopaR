#' Base URL to the API.
API_BASE_URL <- function() {
  "https://mehdiechchelh.com/api/rfr/"
}


#' Build path to the RFR (risk-free rate) endpoint.
#' @param type see the list of types available by the api
#' @param region see the list of regions available by the api
#' @param params additionnal GET parameters
PATH_GET_RFR <- function(type, region, params) {
  sprintf("/api/rfr/%s/%s/?%s",
          type,
          region,
          paste(names(params), params, sep = "=", collapse = "&"))
}


#' Build path to the options endpoint.
#' @param field the field name for the endpoint giving the available options
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

#' This returns a list of the available options for the risk-free-rates curves.
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
