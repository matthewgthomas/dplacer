#' Get data about a society
#'
#' @description Get data about a particular society listed in D-Place (d-place.org)
#'
#' @param ext_id character, ID of the society
#' @param path character, address in the API to call
#' @return list containing society data, including `env` and `trait` objects with variables and values
#' @export
dplace_society <- function(ext_id = NULL, path = "society") {
  if (is.null(path) || is.null(ext_id))
    stop("Nothing to search")

  path = paste(path, ext_id, sep="/")
  req = httr::GET( httr::modify_url( base_uri(), path = path ), ua )

  # load html
  out <- httr::content(req, "text")
  doc <- xml2::read_html(out)

  soc_name <- doc %>%
    rvest::html_node("h1") %>%
    rvest::html_text()

  soc_name <- gsub("^.*\\: ", "", soc_name)  # keep data after the colon

  # the first five <h4> tags contain info about this society - grab the data and parse
  soc_info <- doc %>%
    rvest::html_nodes("h4") %>%
    rvest::html_text() %>%
    .[1:5]

  # get data source (the text after "in" and before the colon)
  soc_source <- gsub("^.*in (.*)\\:.*", "\\1", soc_info[1])

  soc_info <- gsub("^.*\\: ", "", soc_info)  # keep data after the colons

  # parse climate, ecology and physical landscape tables
  env <- doc %>%
    rvest::html_nodes(xpath="//*[@id and starts-with(@id, 'e')]") %>%  # get <div>s beginning with 'e': some/all of eClimate", "ePhysicallandscape" and "eEcology"
    rvest::html_nodes("table") %>%
    #.[1:3] %>%                               # keep first three tables only
    rvest::html_table(header=T, fill=T) %>%  # convert to a list of data.frames
    lapply(function(x) x[,-3]) %>%           # get rid of useless 'NA' column
    lapply(function(x) dplyr::mutate_each(x, dplyr::funs('as.character'))) %>%  # convert each variable to character (so no errors if types mismatch when binding rows)
    dplyr::bind_rows()                       # convert the list of data.frames into a single df

  # keep only labels and codes for cultural trait data (tables 4 onwards [except last table])
  traits <- doc %>%
    rvest::html_nodes(xpath="//*[@id and starts-with(@id, 'c')]") %>%  # get <div>s starting with 'c': they contain the cultural trait tables
    rvest::html_nodes("table") %>%
    #.[4:(length(.)-1)] %>%                   # keep tables 4 until penultimate
    rvest::html_table(header=T, fill=T) %>%  # convert to a list of data.frames
    lapply(function(x) x[-1,1:4]) %>%        # get rid of useless 'NA' columns and first row (which actually contains what we want to use as table headers)
    dplyr::bind_rows() %>%                   # convert the list of data.frames into a single df
    dplyr::distinct()                        # de-dupe
  names(traits) <- c("Label", "Name", "Code", "Description")

  return(list(
    soc_name      = soc_name,
    soc_source    = soc_source,
    original_name = soc_info[1],
    lang_family   = soc_info[2],
    lang_dialect  = soc_info[3],
    alt_names     = soc_info[4],
    data_year     = soc_info[5],
    env           = env,
    traits        = traits
  ))
}
