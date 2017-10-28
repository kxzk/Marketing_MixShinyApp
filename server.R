library(shiny)
library(igraph)
library(scales)
library(networkD3)
library(tidytext)
library(readr)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(DT)
library(ChannelAttribution)
library(reshape)


function(input, output) {

  # reactive element for data reading in
  data  <- reactive({
    #req(input$file1)
    #df  <- read_csv(input$file1$datapath)
    df  <- read_csv('pathdata.csv')
  })


  # input -> data table
  output$contents  <- DT::renderDataTable({
  
    DT::datatable(data(),
      class = 'stripe hover compact order-column',
      options = list(
        searching = FALSE,
        pageLength = 50))
  })

  # output -> data table
  output$modelData  <- DT::renderDataTable({

    md  <- markov_model(data(), 'path', 'total_conversions', var_value = 'total_conversion_value', order = input$kOrder)

    DT::datatable(md,
      class = 'stripe hover compact order-column',
      options = list(
        columnDefs = list(list(className = 'dt-center', targets = '_all')),
        searching = FALSE,
        pageLength = 50),
      filter = 'top') %>%
      formatCurrency('total_conversion_value') %>%
      formatStyle('total_conversion_value',
        fontWeight = 'bold',
        background = styleColorBar(md$total_conversion_value, 'lightgreen')) %>%
      formatRound('total_conversion', 2) %>%
      formatStyle('total_conversion',
        fontWeight = 'bold')

  })


  # output -> total conversion graph
  output$totalConversions  <- renderPlot({
  
    h  <- heuristic_models(data(), 'path', 'total_conversions', var_value = 'total_conversion_value')

    # markov model
    m  <- markov_model(data(), 'path', 'total_conversions', var_value = 'total_conversion_value', order = 1)

    R  <- merge(h, m, by='channel_name')

    R1 <- R[, (colnames(R)%in%c('channel_name', 'first_touch_conversions', 'last_touch_conversions', 'linear_touch_conversions', 'total_conversion'))]

    # Renames the columns
    colnames(R1) <- c('channel_name', 'first_touch', 'last_touch', 'linear_touch', 'markov_model') 

    # Transforms the dataset into a data frame that ggplot2 can use to graph the outcomes
    R1 <- melt(R1, id='channel_name')

    g  <- ggplot(R1, aes(channel_name, value, fill = variable)) +
      geom_bar(stat='identity', position='dodge') +
      theme(axis.title.x = element_text(vjust = -2)) +
      theme(axis.title.y = element_text(vjust = +2)) +
      theme(title = element_text(size = 16)) +
      theme(plot.title=element_text(size = 20)) +
      ylab("") +
      theme_fivethirtyeight() +
      scale_fill_discrete(name = "model")

    g
  })


  # output -> conversion value graph
  output$conversionValue  <- renderPlot({
  

    h  <- heuristic_models(data(), 'path', 'total_conversions', var_value = 'total_conversion_value')

    # markov model
    m  <- markov_model(data(), 'path', 'total_conversions', var_value = 'total_conversion_value', order = 1)

    R  <- merge(h, m, by='channel_name')

    R1 <- R[, (colnames(R)%in%c('channel_name', 'first_touch_conversions', 'last_touch_conversions', 'linear_touch_conversions', 'total_conversion'))]

    # Renames the columns
    colnames(R1) <- c('channel_name', 'first_touch', 'last_touch', 'linear_touch', 'markov_model') 

    # Transforms the dataset into a data frame that ggplot2 can use to graph the outcomes
    R1 <- melt(R1, id='channel_name')

    R2 <- R[, (colnames(R)%in%c('channel_name', 'first_touch_value', 'last_touch_value', 'linear_touch_value', 'total_conversion_value'))]

    colnames(R2) <- c('channel_name', 'first_touch', 'last_touch', 'linear_touch', 'markov_model')

    R2 <- melt(R2, id='channel_name')

    g  <- ggplot(R2, aes(channel_name, value, fill = variable)) +
      geom_bar(stat='identity', position='dodge') +
      theme(axis.title.x = element_text(vjust = -2)) +
      theme(axis.title.y = element_text(vjust = +2)) +
      theme(title = element_text(size = 16)) +
      theme(plot.title=element_text(size = 20)) +
      ylab("") +
      theme_fivethirtyeight() +
      scale_y_continuous(labels = dollar) +
      scale_fill_discrete(name = "model")

    g

  })


  output$totalConv  <- renderValueBox({

    conv  <- data()

    totalConv  <- sum(conv$total_conversions)

    valueBox(
      value = totalConv,
      color = "red",
      subtitle = "Total Conversions",
      icon = icon("money")
    )

  })


  output$totalConvValue  <- renderValueBox({
  
    conv  <- data()

    totalValue  <- sum(conv$total_conversion_value)
    totalValue  <- dollar_format()(totalValue)

    valueBox(
      value = totalValue,
      color = "red",
      subtitle = "Total Conversion Value",
      icon = icon("usd")
    )
  })

  # networkGraph -> graph
  #output$netGraph  <- renderForceNetwork({
#
    #data <- data()
#
    #data$path  <- gsub(">", " ", data$path)
#
    #paths  <- data %>%
      #unnest_tokens(bigram, path, token="ngrams", n = 2) %>%
      #separate(bigram, c("from", "to"), sep = " ") %>%
      #graph_from_data_frame()
#
    #igraph.D3  <- igraph_to_networkD3(paths, group = total_conversion_value)
#

  #})


}
