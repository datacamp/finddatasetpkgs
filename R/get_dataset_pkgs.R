utils::globalVariables(".")

#' Get CRAN R packages with datasets
#'
#' Gets a data frame of CRAN R Packages that mention "dataset" or "data set"
#' in the Title field of their DESCRIPTION file.
#' @param browse Logical. If \code{TRUE}, open the resulting data frame in a
#' browser.
#' @param repos A string pointing to a CRAN instance. If \code{NULL} or
#' \code{NA} then the master CRAN at \url{https://cran.r-project.org} is used.
#' @return A data frame with two columns.
#' \describe{
#' \item{pkgname}{Character. Name of the package.}
#' \item{description}{Character. A quick description of the package.}
#' }
#' @importFrom knitr kable
#' @importFrom magrittr %>%
#' @importFrom magrittr extract
#' @importFrom rvest html_node
#' @importFrom rvest html_table
#' @importFrom stats setNames
#' @importFrom stringr str_detect
#' @importFrom stringr str_replace_all
#' @importFrom stringr regex
#' @importFrom utils browseURL
#' @importFrom withr with_output_sink
#' @importFrom xml2 read_html
#' @export
get_dataset_pkgs <- function(browse = TRUE, repos = getOption("repos")["CRAN"]) {
  if(is.null(repos) || is.na(repos)) {
    repos <- "https://cran.r-project.org"
  }
  cran_url <- file.path(repos, "web/packages/available_packages_by_name.html")
  page <- read_html(cran_url)

  all_pkgs <- page %>%
    html_node(xpath = "//table") %>%
    html_table(fill = TRUE) %>%
    setNames(c("pkgname", "description")) %>%
    extract(
      nzchar(.$pkgname),
    )

  pkgs_with_datasets <- all_pkgs %>%
    extract(
      str_detect(.$description, regex("data ?set", ignore_case = TRUE)),
    )
  pkgs_with_datasets$description <- str_replace_all(
    pkgs_with_datasets$description, regex("\\s"), " "
  )

  if(browse) {
    pkgs_with_datasets$pkgname <- make_link(pkgs_with_datasets$pkgname)
    tfile <- tempfile("pkgs_with_datasets_", fileext = ".html")
    with_output_sink(
      tfile,
      print(kable(pkgs_with_datasets, "html", escape = FALSE))
    )
    browseURL(tfile)
    invisible(pkgs_with_datasets)
  } else {
    pkgs_with_datasets
  }
}

make_link <- function(pkg) {
  sprintf('<a href="https://www.rdocumentation.org/packages/%s" target="_blank">%s</a>', pkg, pkg)
}
