ui <- shiny::fluidPage(
  shiny::titlePanel("Generate your own QR code",
    windowTitle = "QR code SVG/PNG export"
  ),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::textInput(
        inputId = "link",
        label = "Enter Link here", 
        value = "https://agdamsbo.github.io/qr.live/"
      ),
      shiny::tags$hr(),
      # shiny::textInput(inputId = "bgcolor",
      #           label = "SVG Background Color",
      #           value = "white"),
      # shiny::textInput(inputId = "ftcolor",
      #           label = "SVG QR Color",
      #           value = "black"),
      # shiny::h6("Use CSS colors. Use 'none' for transparent."),
      # shiny::tags$hr(),
      shiny::downloadButton(outputId = "save_svg", 
                            label = "Download SVG"),
      shiny::downloadButton(outputId = "save_png", 
                            label = "Download PNG")
    ),
    shiny::mainPanel(
      shiny::plotOutput("plot")
    )
  )
)
