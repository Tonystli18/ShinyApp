#
# This is the server logic of a Shiny web application that allow user to interact with
# mtcars dataset.
#

library(shiny)
shinyServer(function(input, output) {
    model_hp <- reactive({
        brushed_data_hp <- brushedPoints(mtcars, input$brush_hp,
                                      xvar = input$x_hp, yvar = "hp")
        if(nrow(brushed_data_hp) < 2){
            return(NULL)
        }
        lm(as.formula(paste("hp"," ~ ",paste(input$x_hp,collapse="+"))), data = brushed_data_hp)
    })
    
    model_mpg <- reactive({
        brushed_data_mpg <- brushedPoints(mtcars, input$brush_mpg,
                                      xvar = input$x_mpg, yvar = "mpg")
        if(nrow(brushed_data_mpg) < 2){
            return(NULL)
        }
        lm(as.formula(paste("mpg"," ~ ",paste(input$x_mpg,collapse="+"))), data = brushed_data_mpg)
    })
    
    model_qsec <- reactive({
        brushed_data_qsec <- brushedPoints(mtcars, input$brush_qsec,
                                          xvar = input$x_qsec, yvar = "qsec")
        if(nrow(brushed_data_qsec) < 2){
            return(NULL)
        }
        lm(as.formula(paste("qsec"," ~ ",paste(input$x_qsec,collapse="+"))), data = brushed_data_qsec)
    })
    output$plot_hp <- renderPlot({
        xlabel <- switch(input$x_hp,
                         "gear" = "Number of Forward Gears",
                         "carb" = "Number of Carburetors",
                         "cyl" = "Number of Cylinders",
                         "am" = "Transmission (0=automatic, 1=manual)",
                         "mpg" = "Miles/Gallon(US)",
                         "disp" = "Displacement (cu.in.)",
                         "hp" = "Gross Horsepower",
                         "wt" = "Weight (1000 lbs)",
                         "drat" = "Rear axle ratio",
                         "vs" = "Engine(0=V-shaped, 1=straight)")
        if (input$x_hp %in% c("gear", "carb", "cyl", "am", "vs")) {
            boxplot(mtcars$hp ~ mtcars[[input$x_hp]],
                    main = paste("Box plot of", "Gross Horsepower grouped by", xlabel),
                    xlab = xlabel, ylab = "Gross Horsepower")
        } else {
            plot(mtcars[[input$x_hp]], mtcars$hp, 
                 main = paste("Linear Regression of", "Gross horsepower and", xlabel),
                 xlab = xlabel, ylab = "Gross Horsepower", pch = 16 )
            if(!is.null(model_hp())){
                abline(model_hp(), col = "blue", lwd = 2)
            }
        }
        })
    output$plot_mpg <- renderPlot({
        xlabel <- switch(input$x_mpg,
                         "gear" = "Number of Forward Gears",
                         "carb" = "Number of Carburetors",
                         "cyl" = "Number of Cylinders",
                         "am" = "Transmission (0=automatic, 1=manual)",
                         "disp" = "Displacement (cu.in.)",
                         "hp" = "Gross Horsepower",
                         "wt" = "Weight (1000 lbs)",
                         "drat" = "Rear axle ratio",
                         "vs" = "Engine(0=V-shaped, 1=straight)")
        if (input$x_mpg %in% c("gear", "carb", "cyl", "am", "vs")) {
            boxplot(mtcars$mpg ~ mtcars[[input$x_mpg]],
                    main = paste("Box plot of", "Miles/Gallon(US) grouped by", xlabel),
                    xlab = xlabel, ylab = "Miles/Gallon(US)")
        } else {
            plot(mtcars[[input$x_mpg]], mtcars$mpg,
                 main = paste("Linear Regression of", "Miles/Gallon(US) and", xlabel),
                 xlab = xlabel, ylab = "Miles/Gallon(US)", pch = 16 )
            if(!is.null(model_mpg())){
                abline(model_mpg(), col = "blue", lwd = 2)
            }
        }
        })
    output$plot_qsec <- renderPlot({
        xlabel <- switch(input$x_qsec,
                         "mpg" = "Miles per Gallon(US)",
                         "gear" = "Number of Forward Gears",
                         "carb" = "Number of Carburetors",
                         "cyl" = "Number of Cylinders",
                         "am" = "Transmission (0=automatic, 1=manual)",
                         "disp" = "Displacement (cu.in.)",
                         "hp" = "Gross Horsepower",
                         "wt" = "Weight (1000 lbs)",
                         "drat" = "Rear axle ratio",
                         "vs" = "Engine(0=V-shaped, 1=straight)")
        if (input$x_qsec %in% c("gear", "carb", "cyl", "am", "vs")) {
            boxplot(mtcars$qsec ~ mtcars[[input$x_qsec]],
                    main = paste("Box plot of", "1/4 Mile Time grouped by", xlabel),
                    xlab = xlabel, ylab = "1/4 Mile Time")
        } else {
            plot(mtcars[[input$x_qsec]], mtcars$qsec,
                 main = paste("Linear Regression of", "1/4 Mile Time and", xlabel),
                 xlab = xlabel, ylab = "1/4 Mile Time", pch = 16 )
            if(!is.null(model_qsec())){
                abline(model_qsec(), col = "blue", lwd = 2)
            }
        }
        })
    })
