plot1<- function()
{
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  zipName="householdPoerConsumption.zip"
  dir="."
  if(!file.exists("household_power_consumption.txt"))
  {
    downloadZipFileAndUnzip(url,zipName,dir)
  }

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


