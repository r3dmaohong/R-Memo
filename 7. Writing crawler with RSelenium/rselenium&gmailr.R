#########################
## Terminal
## machine name: default
#########################
#' docker-machine start default
#' docker run -d -p 4445:4444 selenium/standalone-firefox

################
#' If 'docker ps' got nothing, try the code below:
# eval "$(docker-machine env default)"
################

#' docker ps
#' docker-machine ip

library(RSelenium)
library(rvest)
library(gmailr)

#' Open a incognito private window with selenium if you have further needs.
#https://stackoverflow.com/questions/40317920/how-to-clear-history-in-rseleniums-internal-web-browser
#https://stackoverflow.com/questions/33224070/how-to-open-incognito-private-window-with-selenium-wd-for-different-browser-type
fprof <- makeFirefoxProfile(
  list(
    "browser.cache.disk.enable" = FALSE,
    "browser.cache.memory.enable" = FALSE,
    "browser.cache.offline.enable" = FALSE,
    "network.http.use-cache" = FALSE,
    "browser.privatebrowsing.autostart" = TRUE
    
  )
)

remDr <- remoteDriver(remoteServerAddr = "192.168.99.100",
                      port = 4445L,
                      extraCapabilities = fprof)
remDr$open(silent = TRUE)
remDr$navigate("https://stackoverflow.com/questions/tagged/r")
remDr$getTitle()
remDr$screenshot(display = TRUE)
#remDr$quit()
#remDr$checkStatus()

search_query <- 'selenium'
webElem <- remDr$findElement(using = 'css',
                                 value = '.js-search-field')
# If you want to clear the original text in the search box.
#webElem$clearElement()
webElem$sendKeysToElement(list(search_query))
webElem$sendKeysToElement(list(key = 'enter'))
remDr$screenshot(display = TRUE)

# Change to the newest results
webElem <- remDr$findElement('xpath', '//*[@id="tabs"]/a[@title="Newest search results"]')
webElem$clickElement()
remDr$screenshot(display = TRUE)

# Get html source
page_source <- remDr$getPageSource()
html_source <- read_html(page_source[[1]])

title <- html_source %>% html_nodes(".result-link") %>%  html_text()
links <- html_source %>% html_nodes(".result-link span a") %>% html_attr('href') %>% paste0("http://stackoverflow.com", .)
stats <- html_source %>% html_nodes(".statscontainer") %>%  html_text()

# Cleaning text result
stats <- trimws(stats)
stats <- gsub('([a-z])([0-9])', '\\1;\\2', gsub("[\n ]", "", stats))

output_df <- data.frame(title = title,
                        links = links,
                        stats)

fn <- paste0("tmp_", format(Sys.time(), "%Y_%m_%d_%H%M%S"), ".csv")
write.csv(output_df, 
          fn, 
          row.namgetes = F)

# Send the result to gmail
html_msg <- mime() %>%
  to(c("@gmail.com", "@gmail.com")) %>%
  from("@gmail.com") %>%
  html_body("")
## Send e-mail with attachment
file_attachment <- html_msg %>%
  subject("Result of crawler") %>%
  attach_file(fn)
send_message(file_attachment)