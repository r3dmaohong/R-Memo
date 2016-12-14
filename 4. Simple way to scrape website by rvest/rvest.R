library(rvest)
library(stringr)

###############################
## Case 1. web page with table
###############################
url  <- c("https://cran.r-project.org/web/packages/available_packages_by_date.html")

## Scrape data from the web page
total_css   <- read_html(url)

## html_nodes: extract pieces out of HTML documents using css selectors
title_css   <- total_css %>% html_nodes("tr th") %>% html_text()
content_css <- total_css %>% html_nodes("tr td") %>% html_text()

## Turning vector to data frame
CRAN_Pkgs <- matrix(content_css, ncol = 3, byrow = T) %>% as.data.frame(., stringsAsFactors = F)

## Trim whitespace from start and end of string
CRAN_Pkgs <- apply(CRAN_Pkgs, 2, str_trim) %>% data.frame(., stringsAsFactors = F)
names(CRAN_Pkgs) <- str_trim(title_css)

CRAN_Pkgs %>% head %>% View

###################################
## Case 2. Crawl mutiple web pages
###################################
for(i in 1:2){
  url <- paste0("http://stackoverflow.com/questions/tagged/r?page=", i)
  
  total_css <- read_html(url)
  
  title_css   <- total_css %>% html_nodes("h3 .question-hyperlink") %>% html_text()
  ## Get an attribute in HTML : "href"
  href_css    <- total_css %>% html_nodes("h3 .question-hyperlink") %>% html_attr("href") %>% paste0("http://stackoverflow.com", .)
  content_css <- total_css %>% html_nodes("div .excerpt") %>% html_text() %>% str_trim()
  
  dat <- cbind(title_css, href_css, content_css) %>% data.frame(., stringsAsFactors = F)
  
  if(i == 1){
    total_dat <- dat
  }else{
    total_dat <- rbind(total_dat, dat)
  }
  ## Setting break time to avoid being banned by the website while crawling multiple pages... 
  Sys.sleep(runif(1,2,4))
}

total_dat %>% head %>% View
