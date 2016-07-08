library(ggplot2)
library(dplyr)

## Problema 1 

## Analisando os gastos comp passagens aéreas

ano.atual <- read.csv("~/Documents/workspace/UFCG/AD1-2016.1/repo/problema-1/dados/ano-atual.csv")

## Selecionando apenas os gastos com passagens aéreas:

gastos.passagens <- subset(ano.atual,txtDescricao == "Emissão Bilhete Aéreo")

summary(gastos.passagens$vlrLiquido)

media.categorias <-group_by(ano.atual, txtDescricao, add = TRUE)


  
##media.categorias.bar <- ggplot(media.categorias, aes(factor(Group.1), vlrLiquido)) + 
 ## geom_bar(stat="identity", position = "dodge")

#media.categorias.bar + coord_flip()

