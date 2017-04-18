#' Get list of cultural codes
#'
#' @export
dplace_codes <- function(path = "codes") {
  if (is.null(path))
    stop("Nothing to search")

  path = paste(rest_path(), path, sep="/")
  out = dplace_getter(path, "")  # no query for first page

  # save first batch of results
  results = out$results

  next_page = 2
  while (!is.null(out$`next`)) {
    q = paste0("page=", next_page)

    out = dplace_getter(path, q)

    results <- dplyr::bind_rows(results, out$results)
    print(paste("Finished page", next_page))
    next_page = next_page + 1
  }

  results
}
