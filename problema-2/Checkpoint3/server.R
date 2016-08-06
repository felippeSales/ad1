

shinyServer(function(input, output) {
  
  output$passageirosPlot <- renderPlotly({
  
    xa <- list(title="")
    ya <- list(title="Número de Pessoas")
    
    print(input$bins)
    print(as.numeric(input$bins)[1])
    
    filtrado <- filter(contagemBilhetesDeputado, Total >= as.numeric(input$bins)[1])
    filtrado <- filter(filtrado, Total <= as.numeric(input$bins)[2])
    
    p <- plot_ly(data=filtrado,
                 text = paste("Parlamentar: ", txNomeParlamentar),
                 color= Partido,
                 mode = "markers",
                 type = "scatter", 
                 marker= list(color=c("lightblue"),
                              opacity = 1, 
                              size = 10, 
                              sizemode = "area", 
                              sizeref = 0.5, 
                              symbol = "circle"),
                 x = Partido,
                 y = Total)%>% layout(xaxis = xa, yaxis = ya)
    
  })
})
