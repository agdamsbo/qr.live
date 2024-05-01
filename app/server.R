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
  tplot <- shiny::reactive({
    qr <- qrcode::qr_code(trimws(input$link), ecl = "M")
    plot(qr)
  })
  output$tplot <- shiny::renderPlot({
    tplot()
  })

  # downloadHandler contains 2 arguments as functions, namely filename, content
  output$save <- shiny::downloadHandler(
    filename = function() {
      paste0(trim_link(input$link), ".svg")
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      qrcode::generate_svg(qrcode::qr_code(trimws(input$link), ecl = "M"), filename = file)
    }
  )
}
