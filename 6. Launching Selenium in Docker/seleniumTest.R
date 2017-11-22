library(RSelenium)

#' Using Docker to setup selenium
#' The link below teach us how to setup Docker and selenium
#' http://rpubs.com/johndharrison/RSelenium-Docker
#' 

#########################
## Terminal
## machine name: default
#########################
#' docker-machine start default
#' docker run -d -p 4445:4444 selenium/standalone-firefox
#' docker ps
#' docker-machine ip
#' 

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                                 port = 4445L)
remDr$open(silent = TRUE)
remDr$navigate("https://www.r-project.org/")
remDr$getTitle()
#' Because using selenium by Docker,
#' there will be no browser poping out.
#' We can use the code below to check the browser's screenshot.
remDr$screenshot(display = TRUE)

#' Click 'download R'
elem <- remDr$findElement(using = 'xpath', '/html/body/div/div[1]/div[2]/p[1]/strong/a')
elem$clickElement()
remDr$getTitle()
remDr$screenshot(display = TRUE)

#########################
## Terminal
## machine name: default
#########################
#' docker-machine stop default
#' docker-machine ls