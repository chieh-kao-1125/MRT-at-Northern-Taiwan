library(tidyr)
library(readODS)
library(lubridate)

## OUT ----
## read all files and make a new one
files <- list.files(path="/YOUR/FILE/PATH/", pattern = "*.ods"
                    , full.names = TRUE, recursive = FALSE)
DATA <- lapply(files, function(x) {
  ods_file <- readODS::read_ods(x, sheet = 1)
  colnames(ods_file)[1] <- "DATA_DATE"
  unp <- tidyr::gather(ods_file, STATION, VALUE
                       , colnames(ods_file)[2]:colnames(ods_file)[ncol(ods_file)])
})
TRTC_OUT <- do.call(rbind, DATA)

## IN ----
## read all files and make a new one
files <- list.files(path="/YOUR/FILE/PATH/", pattern = "*.ods"
                    , full.names = TRUE, recursive = FALSE)
DATA <- lapply(files, function(x) {
  ods_file <- readODS::read_ods(x, sheet = 2)
  colnames(ods_file)[1] <- "DATA_DATE"
  unp <- tidyr::gather(ods_file, STATION, VALUE
                       , colnames(ods_file)[2]:colnames(ods_file)[ncol(ods_file)])
})
TRTC_IN <- do.call(rbind, DATA)


## merge IN & OUT ----
TRTC_DATA <- merge(TRTC_OUT, TRTC_IN, by = c("DATA_DATE", "STATION"), all = TRUE)
colnames(TRTC_DATA)[3:4] <- c("OUT", "IN")
