library(shiny)
library(shinydashboard)


body  <- dashboardBody(

  tabItems(
    tabItem("Inputs",
      fluidRow(
        column(width = 12,
          box(title = "Input Data", width = NULL, solidHeader = TRUE,
              status = "danger",
              DT::dataTableOutput("contents"))
        )
      )
    ),
    tabItem("Outputs",
      fluidRow(
        column(width = 12,
          box(title = "Total Conversions by Channel & Attribution Model", width = NULL, solidHeader = TRUE, status = "danger",
              # plot output
              plotOutput("totalConversions")
              ),
          box(title = "Total Conversion Value by Channel & Attribution Model", width = NULL, solidHeader = TRUE, status = "danger",
              # plot output 
              plotOutput("conversionValue")
              ))
      )
    ),
    tabItem("OutputData",
      fluidRow(
        column(width = 9,
          box(title = "Markov Model Output", width = NULL, solidHeader = TRUE, status = "danger",
              DT::dataTableOutput("modelData"))),
        column(width = 3,
          box(title = "Markov Model K-Order Value", width = NULL, solidHeader = TRUE, status = "danger",
              sliderInput('kOrder', 'K - Order', min = 1, max = 4, value = 1),
              h4("Explanation"),
              p(strong("Order 1:"),"Looks back zero steps. You are currently at Step A (Sequence A). The probability of going anywhere is based on being at that step."),
              p(strong("Order 2:"), "Looks back one step. You came from Step A (Sequence A) and are currently at Step B (Sequence B). The probability of going anywhere is based on where you were and where you are."),
              p(strong("Order 3:"), "Looks back two steps. You came from Step A > B (Sequence A) and are currently at Step C (Sequence B). The probability of going anywhere is based on where you were and where you are."),
              p(strong("Order 4:"), "Looks back three steps. You came from Step A > B > C (Sequence A) and are currently at Step D (Sequence B). The probability of going anywhere is based on where you were and where you are.")
          )
        )
      )
    ) #,
    #tabItem("NetworkGraph",
      #fluidRow(
        #column(width = 12,
          #box(title = "Network Graph", width = NULL, solidHeader = TRUE, status = "danger",
              #
          #)
        #)
      #)
    #)
  ) 
)




ui  <- dashboardPage(
  skin = "red",

  dashboardHeader(
    title = "Markov Model"),

  dashboardSidebar(
    fileInput("file1", "Choose CSV File",
      multiple = TRUE,
      accept = c("text/csv",
                 "text/comma-separated-values,text/plain",
                 ".csv")),
    sidebarMenu(
      menuItem("Input", tabName = "Inputs", icon = icon("folder-o")),
      menuItem("Output Graphs", tabName = "Outputs", icon = icon("signal")),
      menuItem("Output Data", tabName = "OutputData", icon = icon("bars")),
      menuItem("Network Graph", tabName = "NetworkGraph", icon = icon("connectdevelop"))
    )),

  body

)
