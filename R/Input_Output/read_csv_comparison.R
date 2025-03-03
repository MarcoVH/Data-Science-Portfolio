library(readr)
library(data.table)
library(vroom)

# INTERFACE ---------------------------------------------------------------

wd <- "E:\\GIT\\Data-Science-Portfolio\\R\\Input_Output"
data_dir <- "E:\\GIT\\Data-Science-Portfolio\\data\\csv"
csv_file <- "creditcard.csv"

# DEFINITIONS --------------------------------------------------------------------

times_df <- data.frame(
  Method = character(),
  Time = numeric(),
  stringsAsFactors = FALSE
)

measure_time <- function(method, load_function) {
  start_time <- Sys.time()
  data <- load_function(csv_file)
  end_time <- Sys.time()
  time_taken <- end_time - start_time
  times_df <<- rbind(times_df, data.frame(Method = method, Time = as.numeric(time_taken)))
}

# MAIN --------------------------------------------------------------------

setwd(data_d)
measure_time("read.csv", read.csv)
measure_time("readr::read_csv", read_csv)
measure_time("data.table::fread", fread)
measure_time("vroom::vroom", vroom)

print(times_df)