# Reference :
# http://www.troywalters.com/blog/2016/11/29/extracting-tables-pdfs-tabulizer-package/

## If facing problem while intalling tabulizer...
library(ghit)
#http://stackoverflow.com/questions/39132202/trouble-installing-tabulizer-package-for-r
#ghit::install_github(c("leeper/tabulizerjars", "leeper/tabulizer"), INSTALL_opts = "--no-multiarch", dependencies = c("Depends", "Imports"))
library(tabulizer)
library(dplyr)
library(stringr)

##############################################
## Example 1 : table with stable structure...
##############################################
url <- "https://ftp.jctv.ntut.edu.tw/downloads/105/caac/repot_01.pdf"
## Extract tables from pdf
out <- extract_tables(url)
## Encoding problem
out <- sapply(1:length(out), function(x){
  out[[x]] %>% iconv("UTF-8")
})
## Check out tables' ncol
out_ncol <- sapply(1:length(out), function(x){
  out[[x]] %>% ncol
})
out_ncol

## Bind all the pages' table
form1 <- do.call(rbind, out)
form1[form1[,1]=="代碼", ]
headers <- c("代碼", "學校名稱", "系組名稱", "國文權重", "英文權重", "數學權重", 
             "社會權重", "自然權重", "第一階段最低篩選標準")

form1 <- as.data.frame(form1)
names(form1) <- headers
form1 <- form1[form1[,1]!="代碼", ]
head(form1)
write.csv(form1, "form1", row.names = F)


##########################################################
## Example 2 : tables which should adjust their structure  
##########################################################
url <- "http://www.tipo.gov.tw/public/Attachment/613015543548.pdf"
out <- extract_tables(url)
out.backup <- out
out <- sapply(1:length(out), function(x){
  out[[x]] %>% iconv(from="UTF-8", to="UTF-8")
})
out_ncol <- sapply(1:length(out), function(x){
  out[[x]] %>% ncol
})
out_ncol

## This pdf has more than one table...
## First table
## Observe the structure...
## Adjust them...
out[[which(out_ncol==8)[1]]][1,]
out[[which(out_ncol==8)[1]]][,3]
out[[which(out_ncol==8)[1]]][,4]
out[[which(out_ncol==8)[1]]][1, 3] <- out[[which(out_ncol==8)[1]]][1, 4]
out[[which(out_ncol==8)[1]]] <- out[[which(out_ncol==8)[1]]][,-4]

form2_1 <- do.call(rbind, out[1:3])
form2_1[form2_1[,1]=="排名 ", ]
headers <- c("排名", "ID", "申請人中文名稱", "發明", "新型", "設計", "總計")

form2_1 <- as.data.frame(form2_1)
names(form2_1) <- headers
form2_1 <- form2_1[form2_1[,1]!="排名 ", ]
head(form2_1)
write.csv(form2_1, "form2_1.csv", row.names = F)

## Second table
## Observe the structure...
## Adjust them...
out[[which(out_ncol==8)[2]]][1,]
out[[which(out_ncol==8)[2]]][,2]
out[[which(out_ncol==8)[2]]][,3]
out[[which(out_ncol==8)[2]]][1, 2] <- out[[which(out_ncol==8)[2]]][1, 3]
out[[which(out_ncol==8)[2]]] <- out[[which(out_ncol==8)[2]]][,-3]

form2_2 <- do.call(rbind, out[4:7])

##Fill vacancies in the proper order
for(x in 1:(nrow(form2_2)-1)){
  for(i in 1:(nrow(form2_2)-1)){
    if(any(form2_2[i,]=="")){
      if(all(form2_2[i,]=="")){
        form2_2[i,][which(form2_2[i,]=="")] <- form2_2[i+1,][which(form2_2[i,]=="")]
        form2_2[i+1,] <- ""
      }else{
        if(all(form2_2[i+1,][which(form2_2[i,]!="")]=="") & all(form2_2[i+1,][which(form2_2[i,]=="")]!="")){
          form2_2[i,][which(form2_2[i,]=="")] <- form2_2[i+1,][which(form2_2[i,]=="")]
          form2_2[i+1,] <- ""
        }
      }
    }
  }
}
## If words has break to the next line in one cell, it will determine as two cells... 
## So it should be combinded as one cell. 
headers <- c("排名", "申請人中文名稱", "申請人英文名稱", "發明", 
             "新型", "設計", "總計")
form2_2 <- form2_2[rowSums(form2_2=="") != ncol(form2_2),]
form2_2 <- form2_2[which(form2_2[,1]!="排名 "),]
form2_2[which(form2_2[,1]==""), 2] 
form2_2[which(form2_2[,1]=="")-1, 2] <- paste0(str_trim(form2_2[which(form2_2[,1]=="")-1, 2]), str_trim(form2_2[which(form2_2[,1]==""), 2]) )
form2_2[which(form2_2[,1]==""), 3]
form2_2[which(form2_2[,1]=="")-1, 3] <- paste0(form2_2[which(form2_2[,1]=="")-1, 3], str_trim(form2_2[which(form2_2[,1]==""), 3]) )

form2_2 <- as.data.frame(form2_2)
names(form2_2) <- headers
form2_2 <- form2_2[form2_2$排名!="",]

write.csv(form2_2, "form2_2.csv", row.names = F)
