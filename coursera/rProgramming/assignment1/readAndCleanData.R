readDataAndCleanData<-function(url="",fileName="",zipName="",dir=".",sep=",",readFullDir=FALSE,id=c("all"))
{
  
  if(url != "" & !file.exists(paste(dir,fileName,sep="/")))
  {
    downloadZipFileAndUnzip(url,zipName,dir)
  }
  if(readFullDir)
  {
    if(id[1]=="all")
    {
      fileList<- list.files(dir,include.dirs=FALSE)
    }
    else
    {
      fileList<- sprintf("%03d.csv", id)
    }
    
   
    cleanDataSets<-list()
    
    for (i in fileList)
    {
      fullPath<-paste(dir,i,sep="/")
      #print(fullPath)
      if(file.info(fullPath)$isdir)
        next
      
      rawData<-read.csv(fullPath,sep=sep)
      cleanData<-rawData[complete.cases(rawData),]
      cleanDataSets[[length(cleanDataSets)+1]] <- cleanData
    }
    rawData<-cleanDataSets

  }
  else
  {
    rawData<-read.csv(paste(dir,fileName,sep="/"),sep=sep)
  }
  rawData

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