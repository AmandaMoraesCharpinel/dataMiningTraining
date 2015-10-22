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
    numericInput("hp", "Gross horsepower [hp]:", min =52, max = 335, value = 50, step=5),
    br(),
    numericInput("cyl", "Number of cylinders [cyl]:", min =2, max = 8, value = 4, step=2),
    br(),
    numericInput("wt", "Weight (lb/1000) [wt]:", min =1.5, max = 5.5, value = 2.5, step=0.001),
    br(),
    numericInput("gear", "Number of forward gears [gear]:", min =3, max = 5, value = 4, step=1),
    br(),
    selectInput("transmission", "Transmission [am]:",
                list("Manual" = "manual", 
                     "Automatic" = "automatic")),
    br()#,
    #p("Click the button to predict mpg value"),
    #actionButton("goButton", "Predict")
  ),
  
  
  mainPanel( 
    h3("Data analysis"),
    h5("In order to do some preliminary data analysis select one out of three possible box plots.
       You may check if outliers influence the box plot by selecting the respective checkbox."),
    h5(textOutput("caption")),
    plotOutput("mpgPlot"),
    h3("Prediction:"),
    h5("The following content gives you the possibility to test how a change in the input variables influence the result of the 
       prediction based on the regression for mpg on the mtcars as given below. Therefore please change the input variables
       in the sidepanel."),
    tags$div("Call:",
        tags$br(),
        "lm(formula = mpg ~ hp + cyl + wt + gear + am, data = mtcars)",
        tags$br(),
        "Coefficients:",
        tags$br(),
        "(Intercept)           hp          cyl           wt         gear           am  ",
        tags$br(),
        "37.18730     -0.02339     -0.80602     -2.63130     -0.24116      1.66574"
    ),
    h5("The selected input values result in a prediction value of mpg:"),
    verbatimTextOutput("prediction")
  )
))