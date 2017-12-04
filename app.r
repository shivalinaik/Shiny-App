#
#Shivali Naik
#My First Shiny App
#This will be most simple version of shiny app
#2017-Nov-28
#

library(shiny)

choose.files()
artserver<- function(input, output)
{
  
  art.fname<-  "\\\\hd.ad.syr.edu\\03\\f5f887\\Documents\\Desktop\\Shiny\\art(1).csv"
art<- read.csv(file=art.fname,
               header = TRUE
               ,stringsAsFactors = FALSE)
  output$yearlyReciepts <- renderPlot({
    my.title <- "Number of receipts per year"
    barplot(table(art$year),main = my.title,border = "white",col="chartreuse4")
   })
  
  output$storePaper <- renderPlot({
    if(input$store != "None"){
      sub.index <- which(art$store == input$store)
      tmp.data <- art[sub.index, ]
      pie(table(tmp.data$paper), col = c("cadetblue1","antiquewhite"), border = NA)
    }
    
  }
    
  )
  
}

artUI<- fluidPage(
  
  titlePanel("ACME Art Company Dashboard"),
  sidebarLayout(
    sidebarPanel( tags$style (".well{background-color:#528B8B;}"),
        plotOutput("yearlyReciepts"),
      selectInput("store","Select Store:",choices = c("None","Portland","Davenport",
                                                      "Syracuse","Dublin"))
      
      
  ),
  
  mainPanel(
            plotOutput("storePaper"))#closemain panel
)
)
shinyApp(ui = artUI, server = artserver)