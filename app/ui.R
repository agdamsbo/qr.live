ui <- shiny::fluidPage(
  shiny::titlePanel("Generate your own QR code",
    windowTitle = "QR code SVG/PNG export"
  ),
  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::radioButtons(
        inputId = "qr_type",
        label = "What kind of QR code?",
        selected = "text",
        choices = list(
          "Standard (link)" = "text",
          "Wifi credentials" = "wifi"
        )
      ),
      shiny::tags$hr(),
      shiny::conditionalPanel(
        condition = "input.qr_type=='text'",
        shiny::textInput(
          inputId = "link",
          label = "Enter Link here",
          value = "https://agdamsbo.github.io/qr.live/"
        ),
        shiny::radioButtons(
          inputId = "ecl",
          label = "Error correction",
          selected = "M",
          choices = list(
            "Low (7 %)" = "L",
            "Medium (15 %)" = "M",
            "Q (25 %)" = "Q",
            "High (30 %)" = "H"
          )
        ),
        shiny::radioButtons(
          inputId = "logo_add",
          label = "Add logo?",
          selected = "n",
          choices = list(
            "Yes" = "y",
            "No" = "n"
          )
        ),
        shiny::conditionalPanel(
          condition = "input.logo_add=='y'",
          shiny::fileInput(
            inputId = "logo",
            label = "Upload logo file (optional)",
            multiple = FALSE,
            accept = c(
              "png",
              "svg",
              "jpeg",
              "jpg"
            )
          ),
          shiny::radioButtons(
            inputId = "logo_size",
            label = "Logo size (optional)",
            selected = "l",
            choices = list(
              "Small" = "s",
              "Medium" = "m",
              "Large" = "l"
            )
          ),
          shiny::radioButtons(
            inputId = "hjust",
            label = "Horisontal position",
            selected = "l",
            choices = list(
              "Right" = "r",
              "Center" = "c",
              "Left" = "l"
            )
          ),
          shiny::radioButtons(
            inputId = "vjust",
            label = "Vertical position",
            selected = "l",
            choices = list(
              "Top" = "t",
              "Center" = "c",
              "Buttom" = "b"
            )
          )
        )
      ),
      shiny::conditionalPanel(
        condition = "input.qr_type=='wifi'",
        shiny::textInput(
          inputId = "ssid",
          label = "Network name (SSID)",
          value = "hello"
        ),
        shiny::textInput(
          inputId = "key",
          label = "Password",
          placeholder = "pass"
        ),
        shiny::radioButtons(
          inputId = "encryption",
          label = "Encryption",
          selected = "WPA",
          choices = list(
            "WPA/WPA2/WPA3" = "WPA",
            "WEP" = "WEP",
            "None" = "no"
          )
        ),
        shiny::radioButtons(
          inputId = "hidden",
          label = "Hidden?",
          selected = FALSE,
          choices = list(
            "Yes" = TRUE,
            "No" = FALSE
          )
        ),
        shiny::radioButtons(
          inputId = "ecl_wifi",
          label = "Error correction",
          selected = "L",
          choices = list(
            "Low (7 %)" = "L",
            "Medium (15 %)" = "M",
            "High (25 %)" = "Q",
            "Extra High (30 %)" = "H"
          )
        )
      ),
      shiny::tags$hr(),
      shiny::textInput(inputId = "bgcolor",
                label = "Background Color",
                value = "white"),
      shiny::radioButtons(inputId = "transparent",
                       label = "Transparent SVG Background",
                       selected = FALSE,
                       choices = list(
                         "Yes" = TRUE,
                         "No" = FALSE
                       )),
      shiny::textInput(inputId = "ftcolor",
                label = "QR Color",
                value = "black"),
      # shiny::h6("Use CSS colors. Use 'none' for transparent."),
      shiny::tags$hr(),
      # shiny::actionButton(inputId = "render", 
      #                     label = "Generate Preview"),
      # shiny::tags$hr(),
      shiny::downloadButton(
        outputId = "save_svg",
        label = "Download SVG"
      ),
      shiny::downloadButton(
        outputId = "save_png",
        label = "Download PNG"
      )
    ),
    shiny::mainPanel(
      shiny::plotOutput("plot")
    )
  )
)
