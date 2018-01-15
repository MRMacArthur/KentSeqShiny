library(ggplot2)
library(plotly)
library(shiny)
library(DT)

gene.diff <- read.csv("./Data/gene_diff.csv")
gene.diff2 <- read.csv("./Data/gene_diff2.csv")

function(input, output, session) {

  output$volcanoOut <- renderPlotly({
    
    p <- ggplot(data = gene.diff[gene.diff$compared == input$compChoose & -log10(gene.diff$q_value) != 0,], 
                aes(x = log2_fold_change, y = -log10(q_value), 
                    color = significant2,
                    text = paste("Gene:", gene_short_name))) +
      geom_point(alpha = (1/4)) +
      labs(x = "Log2 Fold Change", y = "-log10 q Value") +
      guides(color = guide_legend(title = "Significant"))
    
    p <- ggplotly(p)
    
    print(p)
    
  })
  
  
  output$diffTable <- DT::renderDataTable(DT::datatable({
     
    if (input$tabCompChoose != "All") {
      gene.diff2 <- gene.diff2[gene.diff2$compared == input$tabCompChoose,]
    }
    
    sigVec <- ifelse((abs(gene.diff2$log2_fold_change) > input$FCcut) & 
                       (gene.diff2$q_value < input$qCut), T, F)
    
    cbind(gene.diff2, sigVec)
  
  }))

}