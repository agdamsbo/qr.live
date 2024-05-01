# Prep for shiny
# system2("cat ./R/index_from_raw.R ./R/plot_index.R ./R/read_file.R > ./R/functions.R")

# Typical shiny
shiny::runApp(appDir = here::here("app/") ,launch.browser = TRUE)

# Shinylive version

shinylive::export(appdir = "app", destdir = "docs")

httpuv::runStaticServer(dir = "docs")


# Publish on ... free, limited instance (old traditional shiny host)




