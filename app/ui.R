ui <- shiny::fluidPage(
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      
      shiny::textInput(inputId = "link", label = "Enter Link here", value = "https://agdamsbo.github.io/qr.live/"),
      shiny::downloadButton(outputId = "save", label = "Download QR")
    ),
    shiny::mainPanel(
      shiny::plotOutput("tplot" ) 
    )
  )
)