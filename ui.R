#
# This is the user-interface definition of a Shiny web application that allow user to interact with
# mtcars dataset.
#

library(shiny)

# Define UI for application that draws plots of mtcars dataset
shinyUI(fluidPage(
  # Application title
  titlePanel("Interactive Linear Regressions & Boxplots for mtcars Dataset"),
  
  # Sidebar with three conditional panels:
  # Panel panel_hp: 
  #     hp - dependent variable
  #     user pick up one of other variables as independent variables except qsec
  # Panel panel_mpg: 
  #     mpg - dependent variable
  #     user pick up one of other variables as independent variables except qsec
  # Panel panel_qsec:
  #     qsec - dependent variable
  #     user pick up one of other variables as independent variables
  sidebarLayout(
    sidebarPanel(
        conditionalPanel(
            condition = "input.inTabset == 'panel_hp'",
            h4("Dependent variable: Gross Horsepower"),
            radioButtons("x_hp", "Please select independent variable",
                         c( "Miles per Gallon(US)"="mpg",
                            "Displacement (cu.in.)"="disp",
                            "Weight (1000 lbs)"="wt",
                            "Rear axle ratio"="drat",
                            "Number of forward gears"="gear",
                            "Number of carburetors"="carb",
                            "Transmission"="am",
                            "Number of cylinders"="cyl",
                            "Engine(0=V-shaped, 1=straight)" = "vs"), 
                         selected = "mpg")
        ),
        conditionalPanel(
            condition = "input.inTabset == 'panel_mpg'",
            h4("Dependent variable: Miles per Gallon(US)"),
            radioButtons("x_mpg", "Please select independent variable",
                         c("Gross Horsepower" = "hp",
                           "Displacement (cu.in.)"="disp",
                           "Weight (1000 lbs)"="wt",
                           "Rear axle ratio"="drat",
                           "Number of forward gears"="gear",
                           "Number of carburetors"="carb",
                           "Transmission"="am",
                           "Number of cylinders"="cyl",
                           "Engine(0=V-shaped, 1=straight)" = "vs"), 
                         selected = "hp")
        ),
        conditionalPanel(
            condition = "input.inTabset == 'panel_qsec'",
            h4("Dependent variable: 1/4 Mile Time"),
            radioButtons("x_qsec", "Please select independent variable",
                         c("Miles per Gallon(US)"="mpg",
                           "Gross Horsepower" = "hp",
                           "Displacement (cu.in.)"="disp",
                           "Weight (1000 lbs)"="wt",
                           "Rear axle ratio"="drat",
                           "Number of forward gears"="gear",
                           "Number of carburetors"="carb",
                           "Transmission"="am",
                           "Number of cylinders"="cyl",
                           "Engine(0=V-shaped, 1=straight)" = "vs"), 
                         selected = "mpg")
        )
    ),
    # Show plot of selected dependent and independent variables.
    #  - if user chose an independent variable is essentially numeric variable, it will show points plot
    #    and user can select dots to generate linear regression line
    #  - if user chose an independent variable is essentially factor variable, it will show box plot
    mainPanel(
        tabsetPanel(id = "inTabset",
                    tabPanel(title = "Gross Horsepower", value = "panel_hp",
                             plotOutput("plot_hp", brush = brushOpts(id = "brush_hp"))),
                    tabPanel(title = "Miles per Gallon(US)", value = "panel_mpg",
                             plotOutput("plot_mpg", brush = brushOpts(id = "brush_mpg"))),
                    tabPanel(title = "1/4 mile time", value = "panel_qsec",
                             plotOutput("plot_qsec", brush = brushOpts(id = "brush_qsec")))
                    ),
        fluidRow(
            pre(includeText("User Manual.txt"))
            )
        )
    )
  )
  )
