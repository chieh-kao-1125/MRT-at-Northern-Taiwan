#### PACKAGES ----
##install.packages("tidyr")
##install.packages("readODS")
##install.packages("lubridate")

library(tidyr)
library(readODS)
library(lubridate)

#### DOWNDLOAD DATA OF LAST MONTH ----
LASTMONTH <- format(ymd(Sys.Date())-months(1), "%Y%m")
URL <- paste("https://web.metro.taipei/RidershipPerStation/", LASTMONTH, "_cht.ods", sep = "")
DEST <- paste("/YOUR/FILE/PATH/", LASTMONTH, "_cht.ods", sep = "")

## REMOVE FIRST, DOWNLOAD AFTER
if(exists("DATALASTMONTH")) {
  file.remove(DEST)
  download.file(URL, DEST, mode = "wb")
} else {
    download.file(URL, DEST, mode = "wb")
  }

