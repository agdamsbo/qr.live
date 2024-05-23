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
  v <- shiny::reactiveValues(
    plot = NULL
  )

  qr <- shiny::reactive({
    live_qr_code <- function(x = input$link,
                             ecl = input$ecl) {
      qrcode::qr_code(
        x = trimws(x),
        ecl = ecl
      )
    }

    live_qr_wifi <- function(ssid = input$ssid,
                             encryption,
                             key = input$key,
                             hidden = input$hidden,
                             ecl = input$ecl_wifi) {
      qrcode::qr_wifi(
        ssid = ssid,
        encryption = encryption,
        key = key,
        hidden = hidden,
        ecl = ecl
      )
    }

    live_qr_logo <- function(code,
                             logo = input$logo$datapath,
                             ecl = "L",
                             hjust = input$hjust,
                             vjust = input$vjust) {
      qrcode::add_logo(
        code = code,
        logo = logo,
        ecl = ecl,
        hjust = hjust,
        vjust = vjust
      )
    }


    if (input$qr_type == "text") {
      if (input$logo_add == "n") {
        out <- live_qr_code()
      } else if (input$logo_add == "y") {
        out <- live_qr_logo(
          code = live_qr_code(
            ecl = list("s" = "M", "m" = "Q", "l" = "H")[[input$logo_size]]
          )
        )
      }
    } else if (input$qr_type == "wifi") {
      if (input$encryption %in% c("WPA", "WEP")) enc <- input$encryption else enc <- NULL
      if (input$logo_add == "n") {
        out <- live_qr_wifi(encryption = enc)
      } else if (input$logo_add == "y") {
        out <- live_qr_logo(
          code = live_qr_wifi(
            encryption = enc,
            ecl = list("s" = "M", "m" = "Q", "l" = "H")[[input$logo_size]]
          )
        )
      }
    }
    out
  })

  shiny::observeEvent(input$render, {
    v$plot <- qr()
  })

  output$plot <- shiny::renderPlot({
    if (is.null(v$plot)) {
      return()
    }
    plot(v$plot,
      col = c(
        input$bgcolor,
        input$ftcolor
      )
    )
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
