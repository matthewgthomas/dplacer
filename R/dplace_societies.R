#' Get data about all societies listed in D-Place
#'
#' @description Get data about all societies listed in D-Place (d-place.org)
#'
#' @param path character, address in the API to call
#' @return data.frame containing all societies in D-Place
#'
#' @export
dplace_all_societies <- function(path = "societies") {
  if (is.null(path))
    stop("Nothing to search")

  path = paste(rest_path(), path, sep="/")
  out = dplace_all_societies_(path, "")  # no query for first page

  # save first batch of results
  results = out$results

  # do we need to query more pages?
  # there's probably a better way of doing this than risking getting stuck in a while loop
  # can we find out how many pages in total? Perhaps count / no.results in first page
  next_page = 2
  while (!is.null(out$next_page)) {
    q = paste0("page=", next_page)

    out = dplace_all_societies_(path, q)

    results <- dplyr::bind_rows(results, out$results)
    print(paste("Finished page", next_page))
    next_page = next_page + 1
  }

  results
}

#' Get one page of results about societies from D-Place
#'
#' Use \code{\link{dplace_all_societies}} instead.
#'
#' @param path character, address in the API to call
#' @param query character, which page to return. Format: "page=X"
#' @return data.frame
#'
dplace_all_societies_ <- function(path = NULL, query = NULL) {
  # get from the current path and query
  doc = dplace_getter(path, query)
  results = doc$results

  # location coordinates need to be split into two columns
  # this function will unlist the coordinates and convert them into a data frame
  # 'res' is the results data frame
  # 'col' is the name of the column containing the list of coordinates
  convert_coords <- function(res, col) {
    t( matrix( unlist( res[[col]] ),
               nrow = length(unlist( res[[col]][1] )),
               dimnames = list( c( paste0(col, ".x"),
                                   paste0(col, ".y"))) ) ) %>%
      dplyr::as_data_frame()
  }

  # convert the two coordinates variables and append to results
  results <- dplyr::bind_cols(results, convert_coords(results, "location.coordinates"))
  results <- dplyr::bind_cols(results, convert_coords(results, "original_location.coordinates"))

  # remove the lists of coordinates
  results$location.coordinates <- NULL
  results$original_location.coordinates <- NULL

  list(next_page = doc$`next`, results = results)
}
