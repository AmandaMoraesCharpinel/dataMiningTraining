## 'directory' is a character vector of length 1 indicating
## the location of the CSV files

## 'threshold' is a numeric vector of length 1 indicating the
## number of completely observed observations (on all
## variables) required to compute the correlation between
## nitrate and sulfate; the default is 0

## Return a numeric vector of correlations
corr <- function(directory, threshold = 0) {
   source("readAndCleanData.R")
   cleanedDataSets<-readDataAndCleanData(dir=directory, readFullDir=TRUE)
   results<-vector(mode="numeric",length=0)
   for(i in cleanedDataSets)
   {
     if(nrow(i) > threshold)
     {
       results<-append(results,cor(i$sulfate,i$nitrate) )
     }
   }
  results
}