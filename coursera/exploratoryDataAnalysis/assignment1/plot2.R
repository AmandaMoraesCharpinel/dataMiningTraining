plot2<- function(plotPng=TRUE)
{
  source("readAndCleanData.R")
  trimmedData<-readDataAndCleanData()
  if(plotPng)
  {
    png("plot2.png", height=480, width=480)
  }
  plot(trimmedData$PosixDate,trimmedData$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
  if(plotPng)
  {
    dev.off()
  }
}