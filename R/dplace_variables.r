#' Get list of cultural variables
#'
#' To do:
#' [ ] the 'index_categories' column is currently a jagged list; convert it to separate columns
#'
#' @export
dplace_variables <- function(path = "variables") {
  if (is.null(path))
    stop("Nothing to search")

  path <- paste(rest_path(), path, sep="/")
  out <- dplace_getter(path, "")  # no query for first page

  # save first batch of results
  results <- out$results

  next_page <- 2
  while (!is.null(out$`next`)) {
    q <- paste0("page=", next_page)

    out <- dplace_getter(path, q)

    results <- dplyr::bind_rows(results, out$results)
    print(paste("Finished page", next_page))
    next_page <- next_page + 1
  }

  results
}


