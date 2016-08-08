

shinyServer(function(input, output) {
  
  output$passageirosPlot <- renderPlotly({
  
    xa <- list(title="Total Gasto em R$")
    ya <- list(title="Número de Pessoas")
    
    filtrado <- filter(contagemBilhetesDeputado, total_pessoas >= as.numeric(input$bins)[1])
    filtrado1 <- filter(filtrado, total_pessoas <= as.numeric(input$bins)[2])
    
    filtrado2 <- filter(filtrado1, total_vlr >= as.numeric(input$bins2)[1])
    filtrado3 <- filter(filtrado2, total_vlr <= as.numeric(input$bins2)[2])
    
    p <- plot_ly(data=filtrado3,
                 text = paste(paste("Parlamentar: ", txNomeParlamentar), paste("\n Total Liquido: R$", total_vlr) ),
                 color= Partido,
                 mode = "markers",
                 type = "scatter", 
                 marker= list(color=c("lightgreen"),
                              opacity = 1, 
                              size = 10, 
                              sizemode = "area", 
                              sizeref = 0.5, 
                              symbol = "circle"),
                 x = total_vlr,
                 y = total_pessoas)%>% layout(xaxis = xa, yaxis = ya)
    
  })
})
