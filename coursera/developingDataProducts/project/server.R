library(shiny)
library(datasets)

# We tweak the "am" field to have nicer factor labels. Since this doesn't
# rely on any user inputs we can do this once at startup and then use the
# value throughout the lifetime of the application
mpgData <- mtcars
mpgData$am <- factor(mpgData$am, labels = c("Automatic", "Manual"))
set.seed(1234)
fit <- lm(mpg ~ hp + cyl + wt + gear + am, data=mtcars)
mpgPrediction <- function(hp,wt,cyl,gear,transmission)
{
  am <- 0
  if(transmission == "manual")
    am = 1
  
  predict(fit, data.frame(hp = c(hp), cyl=c(cyl),wt=c(wt) ,gear=c(gear), am=c(am)))
}


# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {

  fitter <- reactive({
                fit <- lm((mpg ~ hp + cyl + wt + gear + am), data=mtcars)
            return(fit)
        })
        output$Evaluation <- renderTable({
            summary(fit)
        })
  
  # Compute the forumla text in a reactive expression since it is 
  # shared by the output$caption and output$mpgPlot expressions
  formulaText <- reactive({
    paste("mpg ~", input$variable)
  })

  # Return the formula text for printing as a caption
  output$caption <- renderText({
    formulaText()
  })

  # Generate a plot of the requested variable against mpg and only 
  # include outliers if requested
  output$mpgPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = mpgData,
            outline = input$outliers)
  })
  
  output$prediction <- renderPrint({mpgPrediction(input$hp,input$wt,input$cyl,input$gear,input$transmission)})
})