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
        column(width = 9,
          box(title = "Total Conversions", width = NULL, solidHeader = TRUE, status = "danger",
              # plot output
              ),
          box(title = "Total Conversion Value", width = NULL, solidHeader = TRUE, status = "danger",
              # plot output 
              ))
      )
    ),
    tabItem("NetworkGraph",
      fluidRow(
        column(width = 12,
          box(title = "Marketing Mix Network Graph", width = NULL, solidHeader = TRUE, status = "danger",
              # plot output 
              ))))
  )
)



ui  <- dashboardPage(
  skin = "red",

  dashboardHeader(
    title = "K-Order Markov Attribution Model"),

  dashboardSidebar(
    fileInput("file1", "Choose CSV File",
      multiple = TRUE,
      accept = c("text/csv",
                 "text/comma-separated-values,text/plain",
                 ".csv")),
    sidebarMenu(
      menuItem("Input", tabName = "Inputs", icon = icon("folder-o")),
      menuItem("Output", tabName = "Outputs", icon = icon("bar-chart")),
      menuItem("NetworkGraph", tabName = "Network Graph", icon = icon("connectdevelop"))
    )),

  body

)
