#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  titlePanel("Checkpoint 3 - #MeLevaParlamentar"),
  
  br(),
  br(),
  
  p("Analisando os gastos dos deputados durante o ano 2016 percebe-se que uma das categorias em que eles mais gastão é com a Emissão de Billhetes Aéreos. Partindo disso
    a pergunta que surgiu foi, eles emitem bilhetes para outras pessoas ou só para eles mesmos?"),
  
  
  br(),
  
  sidebarLayout(
    sidebarPanel(
      
    ),
    mainPanel(
    )
  )
  
))
