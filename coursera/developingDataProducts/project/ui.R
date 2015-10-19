# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Miles Per Gallon Prediction"),

  # Sidebar with controls to select the variable to plot against mpg
  # and to specify whether outliers should be included
  sidebarPanel(
    selectInput("variable", "Select one out of three boxplots for analysis of the variable:",
                list("Cylinders" = "cyl", 
                     "Transmission" = "am", 
                     "Gears" = "gear")),

    checkboxInput("outliers", "Show outliers in the boxplot", FALSE),
    br(),br(),
    h4("Change the following variables to predict mpg:"),
    br(),
    numericInput("hp", "Gross horsepower:", min =52, max = 335, value = 50, step=5),
    br(),
    numericInput("cyl", "Number of cylinders:", min =2, max = 8, value = 4, step=2),
    br(),
    numericInput("wt", "Weight (lb/1000):", min =1.5, max = 5.5, value = 2.5, step=0.001),
    br(),
    numericInput("gear", "Number of forward gears:", min =3, max = 5, value = 4, step=1),
    br(),
    selectInput("transmission", "Transmission",
                list("Manual" = "manual", 
                     "Automatic" = "automatic")),
    br()#,
    #p("Click the button to predict mpg value"),
    #actionButton("goButton", "Predict")
    
  ),
  
  
  mainPanel( 
    h3(textOutput("caption")),
    plotOutput("mpgPlot"),
    
    h3("The selected values result in a prediction value of mpg:"),
    verbatimTextOutput("prediction")
  )
))