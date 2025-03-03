  library(readr)
  library(data.table)
  library(vroom)
  library(arrow)
  
  # INTERFACE ---------------------------------------------------------------

  data_dir <- "E:\\GIT\\Data-Science-Portfolio\\data\\csv"
  csv_file <- "creditcard.csv"
  
  # DEFINITIONS --------------------------------------------------------------------
  
  times_df <- data.frame(
    Method = character(),
    Time = numeric(),
    Unit = character(),
    stringsAsFactors = FALSE
  )
  
  get_best_unit <- function(time_seconds) {
    if (time_seconds < 60) {
      return(list(value = round(time_seconds,2), unit = "seconds"))
    } else if (time_seconds < 3600) {
      return(list(value = round(time_seconds / 60,2), unit = "minutes"))
    } else {
      return(list(value = rount(time_seconds / 3600,2), unit = "hours"))
    }
  }
  
  measure_time <- function(method, load_function) {
    start_time <- Sys.time()
    data <- load_function(csv_file)
    end_time <- Sys.time()
    time_taken_seconds <- as.numeric(end_time - start_time, units = "secs")
    best_unit <- get_best_unit(time_taken_seconds)
    times_df <<- rbind(times_df, data.frame(Method = method, Time = best_unit$value, Unit = best_unit$unit))
  }
  
  # MAIN --------------------------------------------------------------------
  
  setwd(data_dir)
  measure_time("read.csv", read.csv)
  measure_time("readr::read_csv", read_csv)
  measure_time("data.table::fread", fread)
  measure_time("vroom::vroom", vroom)
  measure_time("arrow::read_csv_arrow", function(file) {arrow::read_csv_arrow(file)})
  print(times_df)
  
  