#' Title
#'
#' @param data
#'
#' @return
#' @export
#'
#' @examples
#' "https://thierryo.github.io/qrcode/" |> trim_link()
trim_link <- function(data) {
  gsub(
    "\\_$", "",
    gsub(
      "\\_{2,}", "_",
      gsub("[^a-zA-Z0-9]", "_", trimws(data))
    )
  )
}

#' Run local Shiny app for QR print
#'
#' @return shiny app
#' @export
#'
#' @examples
#' # shiny_qr()
shiny_qr <- function(){
  shiny::runApp(appDir = here::here("app/") ,launch.browser = TRUE)
}