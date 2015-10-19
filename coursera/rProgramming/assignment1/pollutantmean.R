## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'pollutant' is a character vector of length 1 indicating
## the name of the pollutant for which we will calculate the
## mean; either "sulfate" or "nitrate".

## 'id' is an integer vector indicating the monitor ID numbers
## to be used

## Return the mean of the pollutant across all monitors list
## in the 'id' vector (ignoring NA values)
pollutantmean <- function(directory, pollutant, id = 1:332) {
  source("readAndCleanData.R")
  cleanedDataSets<-readDataAndCleanData(dir=directory, readFullDir=TRUE,id=id)
  completeData<-c()
  if(pollutant=="sulfate")
  {
    for(i in cleanedDataSets)
    {
      completeData<-c(completeData,i$sulfate)
    }
  }
  else
  {
   for(i in cleanedDataSets)
    {
         completeData<-c(completeData,i$nitrate)
    }
  }
  meanResults<-mean(completeData)
  meanResults<-round(meanResults,digits=3)
  meanResults  
}

       

        