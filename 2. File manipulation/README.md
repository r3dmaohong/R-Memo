# 2. File manipulation

####Contains 
 - Create a zip file
 - Unzip a file
 - Create a folder
 - Copy a file to another folder 
 - Remove a file 
 - Move a file
 - Rename a file

================
```
#Create a zip file
zip(zipfile = "filename.zip", files = "filename")

#Unzip a file
unzip("filename.zip", exdir = "destination folder")

#Create a folder
dir.create("foldername", recursive=TRUE)

#Copy a file to another folder
file.copy(from = "filename", to = "foldername")

#Remove a file 
file.remove("filename")

#Move a file
file.rename(from = "filename",  to = "folder\\filename")

#Rename a file
file.rename(from = "filename",  to = "filenameAfter")
```



[Code Example](https://github.com/r3dmaohong/R-Memo/blob/master/2.%20File%20manipulation/file_manipulation.R)