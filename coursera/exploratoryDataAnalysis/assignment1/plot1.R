plot1<- function(plotPng=TRUE)
{
  source("readAndCleanData.R")
  trimmedData<-readDataAndCleanData()

  #trimmedData$Global_active_power<-as.numeric(trimmedData$Global_active_power)
  if(plotPng)
  {
    png("plot1.png", height=480, width=480)
  }
  hist(trimmedData$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", main="Global Active Power",breaks=seq(0,8,0.5),xaxt="n",yaxt="n")
  axis(1, at=seq(0, 6, by=2), labels=c("0", "2", "4", "6")) 
  axis(2, at=seq(0, 1200, by=200), labels=c("0", "200", "400", "600","800","1000","1200")) 
  if(plotPng)
  {
   dev.off()
  }

}






