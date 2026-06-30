# Need this so that package will play nice with dplyr package
# https://community.rstudio.com/t/how-to-solve-no-visible-binding-for-global-variable-note/28887
# more technical solution here: https://cran.r-project.org/web/packages/dplyr/vignettes/programming.html

# other technical solution here:
# https://dplyr.tidyverse.org/articles/programming.html


utils::globalVariables(
  c(
    # helpers
    "val_id",

    # cv_read_calval_tracking
    "event_id",
    "deployment_ast",
    "retrieval_ast",
    "end_date",
    "end_time_ast",
    "start_date",
    "start_time_ast",

    # cv_read_old_calval_tracking
    "validation event id",
    "sensor model",
    "serial number",

    "validation start date",
    "validation start time (AST)",

    "validation end date",
    "validation end time (AST)",

    "val_start_date",
    "val_end_date",
    "val_start_time",
    "val_end_time",

    "validation variable",
    "validation status (CMAR USE)",
    "percent bad do readings",
    "percent bad temp readings",
    "percent bad sal readings",

    "name of calibration attendant",
    "name of validation attendant",
    "notes",

    # cv_create_log
    "deployment_date",
    "retrieval_date",
    "sensor_serial_number",
    "sensor_type",
    "variable",

    # read_old-log
    "deployment_can",
    "retrieval_can",

    # cv_assign_tolerance_flag
    "Fail",
    "Pass",
    "med",
    "n_percent",
    "qc_flag",
    "round_timestamp",
    "tol_lower",
    "tol_upper",
    "value"
  ))







