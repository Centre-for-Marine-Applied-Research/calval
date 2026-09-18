#' Create metadata log from calval tracking sheet
#'
#' @param path File path to the Log folder. Default is the log folder in the
#'   event_id folder on the CMAR R drive.
#'
#' @param event_id The event_id for which to create the log. Must match an entry
#'   in the event_id column of the calval tracking sheet.
#'
#' @return Exports csv file to /log folder in the log format required for
#'   compiling data with \code{sensorstrings}.
#'
#' @importFrom data.table fwrite
#' @importFrom dplyr %>% distinct mutate rename
#' @importFrom lubridate as_date as_datetime
#'
#' @export
#'

cv_create_log <- function(event_id, path = NULL) {
  event_id <- tolower(event_id)

  if (grepl("val", x = event_id, ignore.case = TRUE)) {
    calval_sheet <- "pre"
  }
  if (grepl("post", x = event_id, ignore.case = TRUE)) {
    calval_sheet <- "post"
  }

  if (is.null(path)) {
    path <- "R:/data_branches/water_quality/validation/validation_data"
    path <- file.path(paste0(path, "/", event_id, "/log"))

    if (isFALSE(dir.exists(path))) {
      possible_path <- dir.create(path) # can the path be generated?

      if (isTRUE(possible_path)) {
        dir.create(path)
      } else {
        stop("Cannot create log folder. Check the file path exists: ", path)
      }
    }
  }

  tracking <- cv_read_calval_tracking(sheet = calval_sheet) %>%
    filter(event_id == !!event_id)

  if (nrow(tracking) == 0) {
    stop("No rows in calval tracking for event id ", event_id)
  }

  tracking %>%
    mutate(
      deployment_date = format(start_date),
      retrieval_date = format(end_date)
    ) %>%
    select(
      event_id,
      deployment_date,
      retrieval_date,
      sensor_type,
      sensor_serial_number
    ) %>%
    distinct() %>%
    fwrite(
      file = paste0(path, "/", event_id, "_log.csv"),
      na = "NA",
      showProgress = TRUE,
      col.names = TRUE
    )
}
