 ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'id' is an integer vector indicating the monitor ID numbers
        ## to be used
        
        ## Return a data frame of the form:
        ## id nobs
        ## 1  117
        ## 2  1041
        ## ...
        ## where 'id' is the monitor ID number and 'nobs' is the
        ## number of complete cases
complete <- function(directory, id = 1:332) {   
   source("readAndCleanData.R")
   cleanedDataSets<-readDataAndCleanData(dir=directory, readFullDir=TRUE,id=id)
   result<-data.frame(id=numeric(),nobs=numeric())
   
   fileIDs<-id
   
   id<-numeric(length(fileIDs))
   nobs<-numeric(length(fileIDs))
   counter<-1
   for(i in fileIDs )
   {
     id[counter]<-i
     nobs[counter]<-nrow(cleanedDataSets[[ counter ]])
     counter<-counter+1
   }
   result<-data.frame(id,nobs)
   result
}