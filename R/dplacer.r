#' dplacer - an R interface to the anthropology database, [D-Place](https://d-place.org).
#'
#' @name dplacer
#' @docType package
#'
#' @importFrom jsonlite fromJSON rbind.pages
#' @importFrom httr GET content stop_for_status status_code user_agent modify_url
#' @importFrom dplyr %>% as_data_frame data_frame bind_rows distinct mutate_each funs
#' @importFrom xml2 read_xml read_html
#' @importFrom rvest html_node html_text html_nodes html_table
NULL
