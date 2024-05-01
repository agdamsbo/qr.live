trim_link <- function(data) {
  gsub(
    "\\_$", "",
    gsub(
      "\\_{2,}", "_",
      gsub("[^a-zA-Z0-9]", "_", trimws(data))
    )
  )
}

server <- function(input, output) {
  qr <- shiny::reactive({
    qrcode::qr_code(trimws(input$link), ecl = "M")
  })
  
  output$plot <- shiny::renderPlot({
    plot(qr())
  })

  # downloadHandler contains 2 arguments as functions, namely filename, content
  output$save <- shiny::downloadHandler(
    filename = function() {
      paste0(trim_link(input$link), ".svg")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      qrcode::generate_svg(qrcode = qr(),
                           foreground = input$ftcolor,
                           background = input$bgcolor,
                           filename = file,show = FALSE)
    }
  )
}
