plot4<- function(plotPng=TRUE)
{
  source("readAndCleanData.R")
  trimmedData<-readDataAndCleanData()
  if(plotPng)
  {
    png("plot4.png", height=480, width=480)
  }
  par(mfrow=c(2,2))
  with(trimmedData,{
        plot(trimmedData$PosixDate,trimmedData$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
        plot(PosixDate,Voltage,type="l",xlab="datetime",ylab="Voltage")
        with(trimmedData,plot(PosixDate,Sub_metering_1,col="black" ,type="l",xlab="",ylab="Energy sub metering"))
        with(trimmedData,points(PosixDate,Sub_metering_2,type="l",col="red"))
        with(trimmedData,points(PosixDate,Sub_metering_3,type="l",col="blue"))
        legend(cex=0.5,"topright",col=c("black","red","blue"),lty = c(1, 1, 1),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
        plot(PosixDate,Global_reactive_power,type="l",xlab="datetime")
     })
  if(plotPng)
  {
    dev.off()
  }
}