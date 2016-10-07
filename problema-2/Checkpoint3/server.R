#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(GGally)
library(dplyr)
library(resample)
library(stringr)

movies <- read.csv("ratings-por-filme.csv")
ratings <- read.csv("ratings.csv")

movies$genres <- as.character(movies$genres)
movies$title <- as.character(movies$title)
ratings$rating <- as.double(ratings$rating)

movies = movies %>%
  rowwise() %>%
  mutate(num_genres = length(unlist(strsplit(genres, '[|]'))))

movies = mutate(movies, title=(unlist(strsplit(title,'[(]'))[1]))
movies_tituloSize = mutate(movies, titulo_size = nchar(unlist(strsplit(title,'[:]'))[1]))
movies_tituloSizeFull = mutate(movies, titulo_size = nchar(title))

faz_boots = function(dados,mediana.bool){
    
  generos = unique(dados$genero)
  
  
  if(mediana.bool){
    b = bootstrap(dados[dados$genero == generos[1],], median(rating), R = 1000)
    ci = CI.percentile(b, probs = c(.025, .975))
  }else{
    b = bootstrap(dados[dados$genero == generos[1],], mean(rating), R = 1000)
    ci = CI.bca(b, probs = c(.025, .975))
  }
  
  row.names(ci) <- generos[1]
  
  for(i in 2:length(generos)) {
    if(mediana.bool){
      b = bootstrap(dados[dados$genero == generos[i],], median(rating), R = 1000)
      row = CI.percentile(b, probs = c(.025, .975))
    }else{
      b = bootstrap(dados[dados$genero == generos[i],], mean(rating), R = 1000)
      row = CI.bca(b, probs = c(.025, .975))
    }
    
    row.names(row) <- generos[i]
    
    ci = rbind(ci,row)
  }
  
  cis = data.frame(ci)
  
  cis$genero = row.names(cis)
  
  return(cis)
  
}

faz_boots_var = function(dados){
  
  generos = unique(dados$genero)
  
  b = bootstrap(dados[dados$genero == generos[1],], var(rating), R = 1000)
  ci = CI.percentile(b, probs = c(.025, .975),na.rm=TRUE)
  
  row.names(ci) <- generos[1]
  
  for(i in 2:length(generos)) {
    
    b = bootstrap(dados[dados$genero == generos[i],], var(rating), R = 1000)
    row = CI.percentile(b, probs = c(.025, .975),na.rm=TRUE)
    
    row.names(row) <- generos[i]
    
    ci = rbind(ci,row)
  }
  
  cis = data.frame(ci)
  
  cis$genero = row.names(cis)
  
  return(cis)
  
}

cria_avaliacoes_genero = function(dados){
  df <- data.frame(genero=character(),
                   rating=double(),
                   stringsAsFactors=FALSE)
  
  for(i in 1:nrow(dados)) {
    
    generos = unlist(strsplit(dados[i,]$genres,'[|]'))
    
    for(j in 1:length(generos)){
      df[nrow(df) + 1,]<- c(generos[j],dados[i,]$rating)
    }
  }
  
  df$rating <- as.double(df$rating)
  
  return(df)
}

adiciona_variancia = function(dados,dados_ratings){
  
  teste = dados
  
  teste$var = NA
  
  for(i in 1:nrow(dados)) {
    teste[i,]$var = var(dados_ratings[(dados_ratings$movieId == dados[i,]$movieId),]$rating)
  }
  
  return(teste)
}

movies_genero = cria_avaliacoes_genero(movies)

cis_genero_mediana = faz_boots(movies_genero, TRUE)

cis_genero_media = faz_boots(movies_genero, FALSE)


#Simple

b_cor_titulo = bootstrap(movies_tituloSize, cor(y=titulo_size, x=popularity), R = 1000)
ci_cor_titulo = CI.percentile(b_cor_titulo, probs = c(.025, .975),na.rm=TRUE)

cis_cor_titulo = data.frame(ci_cor_titulo)
cis_cor_titulo$Correlacao = "Correlacao"

#Full

b_cor_titulo = bootstrap(movies_tituloSizeFull, cor(y=titulo_size, x=popularity), R = 1000)
ci_cor_titulo = CI.percentile(b_cor_titulo, probs = c(.025, .975),na.rm=TRUE)

cis_cor_titulo_full = data.frame(ci_cor_titulo)
cis_cor_titulo_full$Correlacao = "Correlacao, Título Completo"
  
##Variancia e Popularidade
movies_var = adiciona_variancia(movies,ratings)
movies_var = na.omit(movies_var)

b_cor_popularidade = bootstrap(movies_var, cor(y=var, x=popularity), R = 1000)
ci_cor_popularidade = CI.percentile(b_cor_popularidade, probs = c(.025, .975),na.rm=TRUE)

cis_cor_popularidade = data.frame(ci_cor_popularidade)
cis_cor_popularidade$Correlacao = "Correlacao, Popularidade x Variância"

#Variancia x Genero

cis_var_genero = faz_boots_var(movies_genero)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$GeneroMedia <- renderPlot({
    
    cis_genero_media %>% 
      ggplot(aes(x = genero, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })
  
  output$GeneroMediana <- renderPlot({
    
    cis_genero_mediana %>% 
      ggplot(aes(x = genero, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })
  
  output$GeneroVar <- renderPlot({
    
    cis_var_genero %>% 
      ggplot(aes(x = genero, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })

  output$TituloCor <- renderPlot({
    
    cis_cor_titulo %>% 
      ggplot(aes(x = Correlacao, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })
  
  output$TituloCorFull <- renderPlot({
    
    cis_cor_titulo_full %>% 
      ggplot(aes(x = Correlacao, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })
  
  output$PopularidadeVarCor <- renderPlot({
    
    cis_cor_popularidade %>% 
      ggplot(aes(x = Correlacao, ymin = X2.5., ymax = X97.5.)) + 
      geom_errorbar(width = .2)
    
  })
  
  })


