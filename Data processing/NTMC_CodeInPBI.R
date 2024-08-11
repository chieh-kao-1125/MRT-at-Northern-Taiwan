library(readODS)
library(tidyr)
library(dplyr)
library(data.table)
library(stringr)

files <- list.files(path="/YOUR/FILE/PATH/", pattern = "*.ods"
                    , full.names = TRUE, recursive = FALSE)

DATA <- lapply(files, function(x) {
  ODS_FILE <- readODS::read_ods(x, sheet = 1)
  
  ## extract information from the original .ods to ODS_DATA
  ODS_DATA <- cbind(ODS_FILE[1], ODS_FILE[4], ODS_FILE[7])
  colnames(ODS_DATA) <- c("STATION", "IN", "OUT")
  ODS_DATA <- ODS_DATA %>% filter(stringr::str_ends(STATION, "站"))
  
  ODS_DATA$IN[ODS_DATA$IN == "..."] <- NA
  ODS_DATA$IN[ODS_DATA$OUT == "..."] <- NA
  
  ## write DATA_DATE column from cell of ODS_FILE
  DATE <- as.character(ODS_FILE[3, 4])
  LOC_YEAR <- unlist(gregexpr("年", DATE))[1]
  YEAR <- as.character(as.numeric(stringr::str_sub(DATE, LOC_YEAR-4, LOC_YEAR-2))+1911)
  MONTH <- ifelse(substr(DATE, LOC_YEAR+2, LOC_YEAR+2) == "月",
                  substr(DATE, LOC_YEAR+1, LOC_YEAR+1),
                  substr(DATE, LOC_YEAR+1, LOC_YEAR+2))
  YMD <- paste(YEAR, MONTH, "1",sep = "/")
  ODS_DATA$DATA_DATE <- YMD
  
  ## split station to code and name columns
  ODS_DATA$STATION_CODE <- ifelse(
    grepl("[\\p{Han}]", substr(ODS_DATA$STATION, 1, 3), perl = TRUE) == TRUE, 
    "",
    substr(ODS_DATA$STATION, 1, 3))
  ODS_DATA$STATION <- ifelse(
    grepl("[\\p{Han}]", substr(ODS_DATA$STATION, 1, 3), perl = TRUE) == TRUE, 
    substr(ODS_DATA$STATION, 1, str_count(ODS_DATA$STATION)-1),
    substr(ODS_DATA$STATION, 4, str_count(ODS_DATA$STATION)-1))
  ##print(DATE)
  ODS_DATA
  
})

NTMC_DATA <- do.call(rbind, DATA)

## alter value to fit the relationship
NTMC_DATA$STATION <- replace(NTMC_DATA$STATION, NTMC_DATA$STATION == "板橋", "Y板橋")
NTMC_DATA$STATION <- replace(NTMC_DATA$STATION, NTMC_DATA$STATION == "紅樹林", "V紅樹林")
NTMC_DATA$STATION <- replace(
  NTMC_DATA$STATION, 
  NTMC_DATA$STATION == "十四張", 
  paste(substr(NTMC_DATA$STATION_CODE[NTMC_DATA$STATION == "十四張"], 1, 1), "十四張", sep = ""))

## write the correct station code to the null data
T_STATION_CODE <- cbind(NTMC_DATA[1], NTMC_DATA[5]) %>% 
  filter(NTMC_DATA$STATION_CODE != "") %>% 
  distinct()
NTMC_DATA$STATION_CODE <- T_STATION_CODE$STATION_CODE[match(NTMC_DATA$STATION, T_STATION_CODE$STATION)]
