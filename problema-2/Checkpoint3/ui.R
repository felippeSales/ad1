#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
  
  titlePanel("Problema 4 - Checkpoint 3"),
  br(),
  br(),
  h3("Dados"),
  p("Os dados aqui analisados são referentes a filmes e seus respectivos gêneros, avaliações,
    títulos e popularidade. O nosso objetivo aqui é tentar estabelecer relações  entre
    essas variáveis utilizano métricas que sejam pertinentes para responder as nossas perguntas.")
  ,
  br(),
  br(),
  h4("1 - Gostaria de saber qual o gênero de filme que costuma ter as melhores avaliações"),
  p("Primeirante, fora Temer, para responder essa pergunta eu tentei utilizar a média de avalições
    que cada título recebeu separando-os por gênero."),
  plotOutput("GeneroMedia"),
  br(),
  p("Analisando somente a média vemos que temos 2 gêneros com as melhores avaliações, são:
    Filme-Noir e Documentário, estando Filme-Noir com a melhor média no geral. Como a média tende a ser muito sensível a outliers, é prudente investigar
    como é a disbribuição dos intervalos tomando como base a mediana."),
  br(),
  plotOutput("GeneroMediana"),
  br(),
  p("De forma geral, vemos que o resultado obtido com as medianas não é muito diferente em relação ao 
    resultado obtido com as médias, exceto pelo fato que agora temos que o Documentário aparece
    empatado com Filme-Noir."),
  br(),
  h4("2 - Gostaria de saber se o tamanho do título tem influência na popularidade do filme"),
  p("Essa curiosidade partiu da lógica que usamos para escrever títulos de textos, onde tentamos
    ser sucintos para atrair a atenção dos leitores mais efetivamente. Para estimar essa influência,
    foi usado o cálculo da correlação entre popularidade e o número de caracteres presentes no
    título do filme, para fazer o cálculo do tamanho nós desconsideramos a parte descritiva que 
    geralmente vem depois dos ':'. Ex: Dracula: Dead and Loving It == Dracula "),
  br(),
  plotOutput("TituloCor"),
  br(),
  p("Observando o gráfico vemos que a correlação é muito baixa. Ainda não satisfeitos com o 
    resultado decidiu-se repetir o teste só que agora considerando também a parte descritiva
    do filme"),
  br(),
  plotOutput("TituloCorFull"),
  br(),
  p("Por fim, mesmo utilizando o título por completo não há uma correlação expressiva entre
    o tamanho do título do filme e a sua popularidade. :/"),
  br(),
  h4("3 - Gostaria de saber se há uma correlação entre popularidade e a variância de suas notas"),
  br(),
  plotOutput("PopularidadeVarCor"),
  p("Ao analizar o gráfico vemos que a correlação entre Popularidade x Variância, embora seja
    negativa, é muito pequena."),
  br(),
  h4("4 - Gostaria de saber qual o gênero possui as notas mais inconsistentes"),
  br(),
  plotOutput("GeneroVar"),
  br(),
  p("Analizando os intervalos não é possível afirmar qual o que tem as notas mais inconsistentes.
    Todavia podemos dizer que os maiores são: Children, Horror e Sci-Fi")

))
