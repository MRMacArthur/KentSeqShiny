library(ggplot2)
library(plotly)
library(shiny)
library(DT)

navbarPage("PKL Seq Data",
           tabPanel("Naive v LPS Volcano Plots",
                    fluidRow(
                      column(2,
                        selectInput("compChoose", label = "Choose Sample Comparison",
                                    choices = c("KOn_KO6h", "WTn_KO6h", "WTn_KOn", "WT6h_KO6h", "WT6h_KOn", "WTn_WT6h"), 
                                    selected = "WTn_KOn")
                        ),
                      column(10,
                        plotlyOutput('volcanoOut', height = 600) 
                        )
                      )
                    ),
           tabPanel("Naive v LPS Differential Tables",
                    titlePanel("Differential Expression DataTables"),
                    fluidRow(
                      column(4,
                             selectInput("tabCompChoose", label = "Choose Sample Comparison",
                                         choices = c("All", "KOn_KO6h", "WTn_KO6h", "WTn_KOn", 
                                                     "WT6h_KO6h", "WT6h_KOn", "WTn_WT6h"), 
                                         selected = "WTn_KOn")),
                      column(4,
                             numericInput("FCcut", "Fold Change Cutoff",
                                          value = 1.5,
                                          min = 0)),
                      column(4,
                             numericInput("qCut", "q-Value Cutoff",
                                          value = 0.05,
                                          min = 0,
                                          max = 1))
                    ),
                    fluidRow(
                      DT::dataTableOutput("diffTable")
                    )
                    ),
           tabPanel("Time Course Plot",
                    fluidRow(
                      column(2,
                             selectInput("TCseq", "Transcript", 
                                         choices = colnames(read.csv("./Data/gene_rep_met_2.csv")))),
                      column(10,
                             plotOutput('TCplot'))
                    )))
           
