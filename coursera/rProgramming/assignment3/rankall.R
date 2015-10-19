
rankall <- function(cause, num = "best") {
  library(dplyr)

  options(warn=-1)
  ## Read outcome data
  outcome <- tbl_df(read.csv("data/outcome-of-care-measures.csv",colClasses = "character"))
 
  ## Check that state and outcome are valid
  if( is.null(outcome) )
    return (outcome)
  
  outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)
  outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)
  outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)
 
  ## Return hospital name in that state with lowest 30-day death
  ## rate
    
  if(identical(cause,"heart attack"))
  {
    nonNaValues<-which(! is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    outcome<-outcome[nonNaValues,]
 
    tmp<- outcome %>% group_by(State) %>% arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.Name)
    outcome<-tbl_df(nthrow(tmp,"State",num))
    
  }
  else if(identical(cause,"heart failure"))
  {
    nonNaValues<-which(! is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    outcome<-outcome[nonNaValues,]
 
    tmp<- outcome %>% group_by(State) %>% arrange(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.Name)    
    outcome<-tbl_df(nthrow(tmp,"State",num))
    
  }
  else if(identical(cause,"pneumonia"))
  {
    nonNaValues<-which(! is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    outcome<-outcome[nonNaValues,]
    
    tmp<- outcome %>% group_by(State) %>% arrange(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, Hospital.Name)
    outcome<-tbl_df(nthrow(tmp,"State",num))
  }    
  else
    stop("invalid outcome")

  outcome<-select(outcome,Hospital.Name,State)
  colNames<-c("hospital","state")
  colnames(outcome)<-colNames
  return (outcome)
}

nthrow <- function(dset,splitvar,n) {
    if(identical(n,"worst"))
      result <- do.call(rbind,by(dset,dset[splitvar],function(x) x[nrow(x),]))
    else if(identical(n,"best"))
    {
      n<-1
      result <- do.call(rbind,by(dset,dset[splitvar],function(x) x[n,]))
    }  
    else
      result <- do.call(rbind,by(dset,dset[splitvar],function(x) x[n,]))
    
    result[,splitvar][is.na(result[,splitvar])] <- row.names(result)[is.na(result[,splitvar])]
    row.names(result) <- NULL
    return(result)
}