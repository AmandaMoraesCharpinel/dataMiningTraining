plot3<- function(plotPng=TRUE)
{
  source("readAndCleanData.R")
  trimmedData<-readDataAndCleanData()
  if(plotPng)
  {
    png("plot3.png", height=480, width=480)
  }
  with(trimmedData,plot(PosixDate,Sub_metering_1,col="black" ,type="l",xlab="",ylab="Energy sub metering"))
  with(trimmedData,points(PosixDate,Sub_metering_2,type="l",col="red"))
  with(trimmedData,points(PosixDate,Sub_metering_3,type="l",col="blue"))
  legend("topright",col=c("black","red","blue"),lty = c(1, 1, 1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  if(plotPng)
  {
    dev.off()
  }
}