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

## alter to make it readable for Power BI
TRTC_OUT <- tidyr::drop_na(TRTC_OUT, VALUE)

## also alter, but may need to be checked if new stations start operating
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "板橋", "BL板橋")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "O頭前庄", "頭前庄")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "O景安", "景安")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "G大坪林", "大坪林")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "臺大醫院", "台大醫院")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, substr(TRTC_OUT$STATION, 1, 5) == "台北101", "台北101/世貿")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "紅樹林", "R紅樹林")
TRTC_OUT$STATION <- replace(TRTC_OUT$STATION, TRTC_OUT$STATION == "十四張", "Y十四張")

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

## alter to make it readable for Power BI
TRTC_IN <- tidyr::drop_na(TRTC_IN, VALUE)

## also alter, but may need to be checked if new stations start operating
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "板橋", "BL板橋")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "O頭前庄", "頭前庄")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "O景安", "景安")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "G大坪林", "大坪林")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "臺大醫院", "台大醫院")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, substr(TRTC_IN$STATION, 1, 5) == "台北101", "台北101/世貿")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "紅樹林", "R紅樹林")
TRTC_IN$STATION <- replace(TRTC_IN$STATION, TRTC_IN$STATION == "十四張", "Y十四張")

## merge IN & OUT ----
TRTC_DATA <- merge(TRTC_OUT, TRTC_IN, by = c("DATA_DATE", "STATION"), all = TRUE)
colnames(TRTC_DATA)[3:4] <- c("OUT", "IN")
TRTC_DATA$STATION <- iconv(TRTC_DATA$STATION, to = "UTF-8")
