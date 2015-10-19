rankhospital <- function(state, cause, num = "best") {
   library(dplyr)
   options(warn=-1)
  ## Read outcome data
  outcome <- tbl_df(read.csv("data/outcome-of-care-measures.csv",colClasses = "character"))
 
  ## Check that state and outcome are valid
  if( is.null(state) || is.null(outcome) )
    return (outcome)

  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  determinedState<-outcome$State == state
  if(sum(determinedState) == 0)
    stop("invalid state")
  
  outcome<-outcome[determinedState ,]
  
  suppressWarnings(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
  suppressWarnings(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
  suppressWarnings(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia<-as.numeric(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))

  

  
  if(identical(cause,"heart attack"))
  {
    outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.Name)
    firstNAIndex <- min(which(is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)))
  }
  else if(identical(cause,"heart failure"))
  {
    outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.Name)
    firstNAIndex <- min(which(is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)))
  }
  else if(identical(cause,"pneumonia"))
  {
    outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,Hospital.Name)
    firstNAIndex <- min(which(is.na(outcome$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)))
  }    
  else
    stop("invalid outcome")
  
  if(identical(num,"best"))
    return ((outcome[1,]$Hospital.Name))
  else if(identical(num,"worst"))
  {
    if(is.infinite(firstNAIndex))
      return ((tail(outcome,n=1)$Hospital.Name))
    else
      return ((outcome[firstNAIndex-1,]$Hospital.Name))
  }  
  else
    return ((outcome[num,]$Hospital.Name))
 
}
