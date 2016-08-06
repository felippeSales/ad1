#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(plotly)
library(ggplot2)
library(dplyr)

ano.atual <- read.csv("~/Documents/workspace/UFCG/AD1-2016.1/repo/problema-1/dados/ano-atual.csv")


emissao_bilhetes <- filter(ano.atual,txtDescricao=="Emissão Bilhete Aéreo")

contagemBilhetesDeputado <- emissao_bilhetes %>% 
  group_by(txNomeParlamentar,txtPassageiro) %>%
  distinct() %>%
  ungroup() %>%
  group_by(txNomeParlamentar) %>%
  summarise(Total = n())

contagemBilhetesDeputado <- arrange(contagemBilhetesDeputado,desc(Total))

contagemBilhetesDeputado$Partido <- ""

for (parlamentar in contagemBilhetesDeputado$txNomeParlamentar){
  parlamentarSelecionado <- filter(ano.atual,txNomeParlamentar==parlamentar)[1,]
  
  partido <- parlamentarSelecionado$sgPartido
  
  contagemBilhetesDeputado$Partido[contagemBilhetesDeputado$txNomeParlamentar == parlamentar] <-  lapply(parlamentarSelecionado$sgPartido, as.character)
  
}

shinyUI(fluidPage(
  titlePanel("Número de passageiros"),
  sidebarPanel(
    sliderInput("bins", "Number of bins:", min = 5, max = 40, value = c(10,35))
  ),
  mainPanel(
    plotlyOutput("passageirosPlot")
  )
))
