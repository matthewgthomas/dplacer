##
## Some common functions/settings/etc.
##
# base uri
base_uri <- function()
  "https://d-place.org"

# rest path
rest_path <- function()
  "api/v1"

# set user agent
ua <- httr::user_agent("https://github.com/matthewgthomas")

#' Function to download and process a page of data from D-Place
#' #' @param path character, address in the API to call
#' @param query character, which page to return. Format: "page=X"
#' @return list of processed JSON
#'
dplace_getter <- function(path = NULL, query = NULL) {
  if (is.null(path))
    stop("Nothing to search")

  req = httr::GET( httr::modify_url( base_uri(), path = path, query = query ), ua )

  # load json into r
  out <- httr::content(req, "text")
  doc <- jsonlite::fromJSON(out, flatten=T, simplifyDataFrame = T)

  if (doc$count == 0)
    stop("Nothing found")

  doc
}
