library(ggplot2)
library(dplyr)


## Analisando os gastos comp passagens aéreas

## Selecionando apenas os gastos com passagens aéreas:
##gastos.passagens <- subset(ano.atual,txtDescricao == "Emissão Bilhete Aéreo")

## Problema 1 

ano.atual <- read.csv("~/Documents/workspace/UFCG/AD1-2016.1/repo/problema-1/dados/ano-atual.csv")



##Panorama dos dados


## Analisando gastos por tipo

vlrLiquidoAgrupadosDescricao <- ano.atual %>% group_by(txtDescricao) %>% summarise(vlrLiquido = sum(vlrLiquido))

ggplot(vlrLiquidoAgrupadosDescricao, aes(factor(txtDescricao), vlrLiquido)) + 
geom_bar(stat="identity", position = "dodge") + coord_flip()

## Analisando gastos por partido

vlrLiquidoAgrupadosPartido <- ano.atual %>% group_by(sgPartido) %>% summarise(vlrLiquido = mean(vlrLiquido))

ggplot(vlrLiquidoAgrupadosPartido, aes(factor(sgPartido), vlrLiquido)) + 
geom_bar(stat="identity", position = "dodge") + coord_flip()


p <- ggplot(ano.atual, aes(datEmissao, vlrLiquido))
p + geom_point()


