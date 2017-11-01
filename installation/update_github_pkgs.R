## Description:
# Update all installed github packages.
## Usage:
# update.packages(ask=F)
# upd8 <- update_github_pkgs()
# library(tidyverse)
# upd8 %>% data.frame %>% gather %>% filter(value)
# upd8 %>% enframe %>% unnest %>% filter(value) # didn't work 27-08-2017; b/c of `colformat`?

update_github_pkgs <- function() {
  if (!("package:devtools" %in% search())) {
    tryCatch(
      require(devtools),
      error = function(x) {
        warning(x)
        cat("Cannot load devtools package \n")
      }
    )
    on.exit(detach("package:devtools", unload = TRUE))
  }
  pkgs <- installed.packages(fields = "RemoteType")
  github_pkgs <- pkgs[pkgs[, "RemoteType"] %in% "github", "Package"]
  print(github_pkgs)
  lapply(github_pkgs, function(pac) {
    message("Updating ", pac, " from GitHub...")
    repo <- packageDescription(pac, fields = "GithubRepo")
    username <- packageDescription(pac, fields = "GithubUsername")
    switch(
      pac,
      data.table = {
        remove.packages("data.table")
        install.packages("data.table", type = "source",
                         repos = "http://Rdatatable.github.io/data.table")
      },
      caret = try(install_github(repo = paste0(username, "/", repo, "/pkg/", repo)))
      ,
      feather = try(install_github(repo = paste0(username, "/", repo, "/R")))
      ,
      forecastHybrid = try(install_github(repo = paste0(username, "/", repo, "/pkg")))
      ,
      fst = try(install_github(repo = paste0(username, "/", repo), ref = "develop"))
      ,
      lme4 = try(install_github(
        repo = paste0(username, "/", repo),
        dependencies = TRUE
      ))
      ,
      R6 = try(install_github(
        repo = paste0(username, "/", repo),
        build_vignettes = FALSE
      ))
      ,
      rstanarm = try(install_github(
        repo = paste0(username, "/", repo),
        args = "--preclean",
        build_vignettes = FALSE
      ))
      ,
      try(install_github(repo = paste0(username, "/", repo)))
    )
  })
}
