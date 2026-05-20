#' Create metadata log from calval tracking sheet
#'
#' @param path File path to the Log folder.
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

cv_create_log <- function(path = NULL, event_id) {

  event_id <- tolower(event_id)

 # if(is.null(path)) path <- ""

  tracking <- cv_read_calval_tracking() %>%
    filter(event_id == !!event_id)

  if(nrow(tracking) == 0) {
    stop("No rows in calval tracking for event id ", event_id)
  }

  tracking %>%
    select(
      event_id,
      deployment = start_date,
      retrieval = end_date,
      sensor_type, sensor_serial_number
    ) %>%
    distinct() %>%
    fwrite(
      file = paste0(path, "/log/", event_id, "_log.csv"),
      na = "NA",
      showProgress = TRUE,
      col.names = TRUE
    )
}




