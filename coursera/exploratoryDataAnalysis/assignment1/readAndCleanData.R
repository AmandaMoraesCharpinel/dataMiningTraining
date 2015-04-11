readDataAndCleanData<-function()
{
  library(lubridate)
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipName="householdPoerConsumption.zip"
  dir="."
  if(!file.exists("household_power_consumption.txt"))
  {
    downloadZipFileAndUnzip(url,zipName,dir)
  }
  if(!file.exists("household_power_consumptionSubSet.txt"))
  {
    rawData<-read.csv("household_power_consumption.txt",sep=";")
    rawData$PosixDate <- dmy_hms(paste(as.character(rawData$Date),as.character(rawData$Time),sep=" "))
    subSet<- subset(rawData,as.Date(PosixDate) == as.Date("2007-02-01") | as.Date(PosixDate) == as.Date("2007-02-02"))
    write.table(subSet,"household_power_consumptionSubSet.txt",sep=';')
    
  }
  rawData<-read.csv("household_power_consumptionSubSet.txt",sep=";")
  rawData$PosixDate <- ymd_hms(as.character(rawData$PosixDate))
  d<-rawData
  d<-d[d$Global_active_power != "?",]
  d
}

downloadZipFileAndUnzip<-function(url, zipFileName, dir)
{
  # run the download file function, download as binary..  save the result to the temporary file
  download.file( url,zipFileName ,
    method="curl",
    mode = 'wb')

  # unzip the files to the temporary directory
  files <- unzip( zipFileName , exdir = dir )
}