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
