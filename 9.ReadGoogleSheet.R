install.packages("googlesheets4")
library(googlesheets4)

gs4_auth(new_user = TRUE)

info_corona <- read_sheet("https://docs.google.com/spreadsheets/d/1Z6wMoCmZeCi0Ynk9H6Zi6BcgiztPF_XypJo-79CnSxg/edit#gid=0", sheet= "Sheet1")
info_corona