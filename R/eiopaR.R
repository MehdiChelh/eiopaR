#' @title Query EIOPA risk-free rate (RFR).
#' @description This function query and returns the EIOPA risk-free interest rate term structures from an API.
#'
#' Note: this function is getting the data from an API. Your IP can be temporary or permanently blocked if too many queries are executed.
#'
#' For optimal performance, we recommend to limit the number of calls to this function.
#'
#' EIOPA website : https://www.eiopa.europa.eu/tools-and-data/risk-free-interest-rate-term-structures_en
#'
#' @param type the type of the risk-free rate, see `options_rfr_types()` for the different options (examples: "with_va", "no_va").
#' @param region the region to query (examples: "FR". see `get_options("region")`).
#' @param year the year of the RFR.
#' @param month the month of the RFR.
#' @param format the format for the output data. Currently the only option is "data.frame".
#' @seealso get_rfr_with_va, get_rfr_no_va
#' @export
#' @include const.R
#' @examples
#' get_rfr("with_va", "FR", 2019, 12)
#' get_rfr("no_va", "FR", c(2016, 2019), 12)
#' get_rfr("no_va", "FR", 2019, 12)
#' get_rfr("no_va_shock_up", "BE", 2020, 11)
get_rfr <-
  function(type = options_rfr_types(),
           region,
           year = NULL,
           month = NULL,
           format = c("data.frame")) {

    if (length(region) != 1){
      stop("'region' should be of length 1.")
    }

    year <- ifelse(is.numeric(year), paste(year, collapse = ","), "")
    month <- ifelse(is.numeric(month), paste(month, collapse = ","), "")
    format <- format[1]
    type <- type[1]

    path <- PATH_GET_RFR(type, region,
                         list(year=year, month=month))

    resp <- api_get(sprintf(path))

    parse_rfr(resp, format)
  }


#' @title Query EIOPA RFR with volatility adjustment.
#' @description This function query and returns the EIOPA risk-free interest rate term structures from an API.
#'
#' Note: this function is getting the data from an API. Your IP can be temporary or permanently blocked if too many queries are executed.
#'
#' For optimal performance, we recommend to limit the number of calls to this function.
#'
#' EIOPA website : https://www.eiopa.europa.eu/tools-and-data/risk-free-interest-rate-term-structures_en
#'
#' @param region the region to query (examples: "FR". see `get_options("region")`).
#' @param year the year of the RFR.
#' @param month the month of the RFR.
#' @param format the format for the output data. Currently the only option is "data.frame".
#' @seealso get_rfr, get_rfr_no_va
#' @export
#' @include const.R
#' @examples
#' get_rfr_with_va("FR", 2019, 12)
#' get_rfr_with_va("BE", 2020, 11)
get_rfr_with_va <- function(region,
                            year = NULL,
                            month = NULL,
                            format = c("data.frame")) {
  type <- WITH_VA()
  get_rfr(
    type = type,
    region = region,
    year = year,
    month = month
  )
}


#' @title Query EIOPA RFR without volatility adjustment
#' @description This function query and returns the EIOPA risk-free interest rate term structures from an API.
#'
#' Note: this function is getting the data from an API. Your IP can be temporary or permanently blocked if too many queries are executed.
#'
#' For optimal performance, we recommend to limit the number of calls to this function.
#'
#' EIOPA website : https://www.eiopa.europa.eu/tools-and-data/risk-free-interest-rate-term-structures_en
#'
#' @param region the region to query (examples: "FR". see `get_options("region")`).
#' @param year the year of the RFR.
#' @param month the month of the RFR.
#' @param format the format for the output data. Currently the only option is "data.frame".
#' @seealso get_rfr, get_rfr_with_va
#' @export
#' @include const.R
#' @examples
#' get_rfr_no_va("FR", 2019, 12)
#' get_rfr_no_va("BE", 2020, 11)
get_rfr_no_va <- function(region,
                          year = NULL,
                          month = NULL,
                          format = c("data.frame")) {
  type <- NO_VA()
  get_rfr(
    type = type,
    region = region,
    year = year,
    month = month
  )
}


#' @title Parse the risk free rates API response
#' @description This function is used to parse data received from the api to various formats.
#' @param resp A response from the API (status 200, type/JSON). The response should have a "data" keyword with the value of an array containing the risk free rates.
#' @param format One of the output format ("data.frame" is currently the only option).
parse_rfr <- function(resp, format){

  if (format == "data.frame"){
    return(parse_rfr_to_df(resp))
  }
}


#' @title Parse the risk free rates API response into a dataframe
#' @description This function is used to parse data received from the api into data.frame.
#' @param resp A response from the API (status 200, type/JSON). The response should have a "data" keyword with the value of an array containing the risk free rates.
parse_rfr_to_df <- function(resp) {

  # Ensure that the reponse contains data
  if (length(resp$content) == 0){
    return(structure(list(data = data.frame(),
                          metadata = data.frame(),
                          format="df"),
                     class="eiopa_rfr"))
  }

  # Metadata
  # --------
  metadata <- lapply(resp$content, function(x) {
    res <- list()
    for (key in names(x))
      if (key != "data")
        res[[key]] <- x[[key]]

    res
  })

  df_metadata <- as.data.frame(t(matrix(unlist(metadata),
                                        nrow = length(
                                          unlist(metadata[1])
                                          ))),
                               col.names = names(metadata[[1]]))

  colnames(df_metadata) <- names(metadata[[1]])

  # Data
  # --------
  data <- lapply(resp$content, function(x) {
    x[["data"]]
  })
  data[[1]]

  df_data <- as.data.frame(matrix(unlist(data),
                                  nrow = length(unlist(data[1]))),
                           stringsAsFactors = FALSE)

  colnames(df_data) <- as.character(df_metadata$id)

  structure(list(data = df_data,
                 metadata = df_metadata,
                 format="df"),
            class="eiopa_rfr")
}


#' @title Options available
#' @description Returns the available options for a specific field.
#' @param field a string like "region", "year" or "month"
#' @examples
#' get_options("region")
#' @export
get_options <- function(field) {
  resp <- api_get(PATH_GET_OPTIONS(field))
  return(unlist(resp$content))
}


#' @title Print eiopa_rfr object
#' @description Print eiopa_rfr object in a readable format
#' @param x a response from the api
#' @param ... further arguments passed to or from other methods.
#' @examples
#' resp <- get_rfr_with_va("FR", 2019, 11)
#' print(resp)
#' @export
print.eiopa_rfr <- function(x, ...) {

  cat("<eiopa_rfr>\n")
  for (i in 1:nrow(x$metadata)){
    cat(sprintf("%s > %s ...\n",
            x$metadata[i, "id"],
            paste(x$data[1:3, i], collapse = ", ")))
  }
  invisible(x)
}

