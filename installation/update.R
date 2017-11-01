## Description:
# update CRAN pkgs then update GH pkgs
update.packages(ask=F, repos = "https://cloud.r-project.org/")
script_dir <- "/home/garrett/programming/r_scripts/rscripts/installation/"
source(paste0(script_dir, "update_github_pkgs.R"))
upd8 <- update_github_pkgs()
library(tidyverse)
upd8 %>% data.frame %>% gather %>% filter(value) %>% print
