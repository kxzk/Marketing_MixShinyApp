library(shiny)
library(tidyverse)
library(ggthemes)
library(DT)
library(ChannelAttribution)


function(input, output) {

  # reactive element for data reading in
  data  <- reactive({
    req(input$file1) 
    df  <- read_csv(input$file1$datapath)

  })

  # reactive model computation
  models  <- reactive({
  
    # simple models
    # h  <- heuristic_models(data, 'path', 'total_conversions', var_value = 'total_conversion_value')

    # markov model
    # m  <- markov_models(data, 'path', 'total_conversions', var_value = 'total_conversion_value', order = 1)

  })

  # input -> data table
  output$contents  <- DT::renderDataTable({
  
    DT::datatable(data(),
      class = 'stripe hover compact order-column',
      options = list(
        pageLength = 50))
  })

  # output -> data table
  output$modelData  <- DT::renderDataTable({


  })


  # output -> total conversion graph
  output$totalConversions  <- renderPlot({
  
  })


  # output -> conversion value graph
  output$conversionValue  <- renderPlot({
  
  })


  # networkGraph -> graph
  output$netGraph  <- renderForceNetwork({
  
  })


}
