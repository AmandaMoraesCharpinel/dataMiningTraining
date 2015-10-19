prob1<-function()
{
  outcome <- read.csv("data/outcome-of-care-measures.csv", colClasses = "character")
  head(outcome)
  outcome[, 11] <- as.numeric(outcome[, 11])
  hist(outcome[, 11])
}

best <- function(state, cause) {
  library(dplyr)
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
    outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,Hospital.Name)
  else if(identical(cause,"heart failure"))
      outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,Hospital.Name)
  else if(identical(cause,"pneumonia"))
    outcome<-arrange(outcome,Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia,Hospital.Name)
  else
    stop("invalid outcome")
  
  return ((outcome[1,]$Hospital.Name))
 
}

