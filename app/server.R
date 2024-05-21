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
  # qr <- shiny::observeEvent(input$render, {
    qr <- shiny::reactive({
      if (input$qr_type == "text") {
        out <- qrcode::qr_code(trimws(input$link), ecl = input$ecl)
        if (!is.null(input$logo)) {
          out <- qrcode::add_logo(
            code = qrcode::qr_code(trimws(input$link), ecl = list("s" = "M", "m" = "Q", "l" = "H")[[input$logo_size]]),
            logo = input$logo$datapath,
            ecl = "L",
            hjust = input$hjust,
            vjust = input$vjust
          )
        }
      } else if (input$qr_type == "wifi") {
        if (input$encryption %in% c("WPA", "WEP")) enc <- input$encryption else enc <- NULL
        out <- qrcode::qr_wifi(
          ssid = input$ssid,
          encryption = enc,
          key = input$key,
          hidden = input$hidden,
          ecl = input$ecl_wifi
        )
      }
    plot(out, col = c(input$bgcolor, input$ftcolor))
      
    })
  # })

  # shiny::reactive(input$render, {
  #   output$plot <- shiny::renderPlot({
  #     plot(qr(),col=c(input$bgcolor,input$ftcolor))
  #   })
  # })

    #inspiration: https://stackoverflow.com/questions/57242792/update-plot-output-on-actionbutton-click-event-in-r-shiny
    
  # output$plot <- shiny::renderPlot({
  #   if (is.null(v$plot)) return()
  #   qr
  # })

    output$plot <- shiny::renderPlot({
      qr()
    })
    
  # downloadHandler contains 2 arguments as functions, namely filename, content
  output$save_svg <- shiny::downloadHandler(
    filename = function() {
      if (input$qr_type == "text") {
        paste0(trim_link(input$link), ".svg")
      } else if (input$qr_type == "wifi") {
        paste0(trim_link(input$ssid), ".svg")
      }
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      qrcode::generate_svg(
        qrcode = qr(),
        foreground = input$ftcolor,
        background = ifelse(input$transparent, "none", input$bgcolor),
        filename = file, show = FALSE
      )
    }
  )

  # downloadHandler contains 2 arguments as functions, namely filename, content
  output$save_png <- shiny::downloadHandler(
    filename = function() {
      if (input$qr_type == "text") {
        paste0(trim_link(input$link), ".png")
      } else if (input$qr_type == "wifi") {
        paste0(trim_link(input$ssid), ".png")
      }
    },
    # content is a function with argument file. content writes the plot to the device
    content = function(file) {
      png(filename = file)
      plot(qr(), col = c(input$bgcolor, input$ftcolor))
      dev.off()
    }
  )
}
