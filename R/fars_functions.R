#' This function, named "fars_read", reads a file and save the data in a variable called "data".
#'
#' @param filename A single string with the name of the file.
#' Only years 2013, 2014 and 2015 are available. Trying loading a different year will result in
#' a message saying the file does not exist.
#'
#' @return The function returns a data frame containing the data of the file. The output
#' file is named "data".
#'
#' @importFrom readr read_csv
#' @importFrom dplyr tbl_df
#'
#' @export
#'
#' @examples
#' \dontrun{dirdata <- system.file("extdata", "accident_2013.csv.bz2", package = "FARSinR2")}
#' \dontrun{fars_read(dirdata)}
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' The make_filename function returns a character vector for the file name, taking the year as argumnent.
#' All values are accepted, no error will be thrown.
#'
#' @param year a value which will be converted to integer.
#'
#' @return the output is a character vector which includes the argument, customizing the file name.
#'
#' @export
#'
#' @examples
#' \dontrun{make_filename(2014)}
#'
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#' fars_read_years function takes a series of years and create an ordenated table for a designated month.
#' The core of the function uses tryCatch, a function for
#' signaling and handling unusual conditions, including errors and warnings.
#'
#' @param years a vector containing the selected years.
#'
#' @return The function returns a data frame containing the month and year columns of the file.
#' It will thrown an error if the year is not valid; the only valid years using the provided data set are 2013, 2014 and 2015.
#' c(2013,2014) is OK, whereas c(2016,2017) will show NULL and a warning message.
#'
#' @export
#'
#' @importFrom dplyr mutate
#' @importFrom dplyr select
#' @importFrom magrittr "%>%"
#'
#' @examples
#' \dontrun{fars_read_years(c(2013,2014))}
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate_(dat, year = year) %>%
        dplyr::select_(.dots = c("MONTH", "year"))
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' fars_summarize_years sumarizes in a monthly basis the accidents in a given years.
#'
#' @param years a vector containing the selected years, for example c(2013, 2014)
#'
#' @return The function returns a data frame containing the month and the values for different years in their respective columns.
#' For example:
#'   MONTH `2013` `2014`
#'   *  <int>  <int>  <int>
#'   1      1   2230   2168
#'   2      2   1952   1893
#'
#' @export
#'
#' @importFrom dplyr bind_rows
#' @importFrom dplyr group_by
#' @importFrom dplyr summarize
#' @importFrom tidyr spread
#' @importFrom magrittr "%>%"
#'
#' @examples
#' \dontrun{fars_summarize_years(c(2013,2014))}
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by_(~ year, ~ MONTH) %>%
    dplyr::summarize_(n = ~ n()) %>%
    tidyr::spread_(key_col = "year", value_col = "n")
}

#' fars_map_state represents geographically the values in a given year and a given state number
#' which have a longitude > 900 and a latitude > 90.
#' It will thrown an error if the year or the state are not valid, or if there are no accidents to show.
#'
#' @note The original function has been adapted to Non-standard evaluation.
#' For example, the filter function below has been modified to filter_
#'
#' @param state.num the number of the selected state
#' @param year the selected year
#'
#' @return The function returns a graphic showing the geographical representation of the data
#'  for a given year and a given state.
#'
#' @export
#'
#' @importFrom maps map
#' @importFrom graphics points
#'
#' @examples
#' \dontrun{fars_map_state(1, 2013)}
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)

  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter_(data, ~ STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
