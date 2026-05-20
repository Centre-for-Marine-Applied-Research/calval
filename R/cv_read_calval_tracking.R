#' Read in CMAR calval tracking sheet
#'
#' @param link Link to the calval tracking sheet on Google Drive. Default is the
#'   CMAR tracking sheet.
#'
#' @param sheet Character string with the name of the sheet to read in or an
#'   abbreviation of the sheet name. Options are \code{sheet = "pre"} and
#'   \code{sheet = "post"}.
#'
#' @importFrom dplyr select
#' @importFrom googlesheets4 gs4_deauth read_sheet
#' @importFrom lubridate with_tz
#'
#' @return Returns a data frame of the calval tracking sheet. Deployment and
#'   retrieval datetimes are appended in "Canada/Atlantic" and "UTC" timezones.
#' @export


cv_read_calval_tracking <- function(link = NULL, sheet = "pre") {

  if(is.null(link)) {
    link <- "https://docs.google.com/spreadsheets/d/19qijvQJcAMg0TQ-Bm3plZ_3CnqHjuuw3XgkdzjU1jcc/edit?gid=0#gid=0"
  }

  sheet <- tolower(sheet)

  if(sheet == "pre") {
    sheet <- "pre_deployment"
  } else if(sheet == "post") {
    sheet <- "post_deployment"
  } else {
    stop("Invalid entry for sheet.\nsheet must be pre or post")
  }

  googlesheets4::gs4_deauth()

  googlesheets4::read_sheet(
    link,
    sheet = sheet,
    na = c("", "NA")
  ) %>%
    filter(!is.na(event_id)) %>%
    mutate(
      event_id = tolower(event_id),

      start_time_ast = if_else(
        nchar(start_time_ast) == 4 | nchar(start_time_ast) == 5,
        paste0(start_time_ast, ":00"), start_time_ast
      ),

      end_time_ast = if_else(
        nchar(end_time_ast) == 4 | nchar(end_time_ast) == 5,
        paste0(end_time_ast, ":00"), end_time_ast
      ),

      deployment_ast = as_datetime(
        paste(start_date, start_time_ast), tz = "Canada/Atlantic"),

      retrieval_ast = as_datetime(
        paste(end_date, end_time_ast), tz = "Canada/Atlantic")

      # deployment_utc = with_tz(deployment_ast, tzone = "UTC"),
      # retrieval_utc = with_tz(retrieval_ast, tzone = "UTC")
    )
}
