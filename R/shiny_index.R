
#' Launch the included Shiny-app for index calculations
#'
#' @return shiny app
#' @export
shiny_app <- function() {
  shiny::runApp(appDir = here::here("app.R") ,launch.browser = TRUE)

  # shiny::shinyApp(
  #   ui_factory(),
  #   server_factory()
  # )
}
