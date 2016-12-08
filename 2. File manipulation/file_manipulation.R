## Facing error while using zip function...
## http://stackoverflow.com/questions/29129681/create-zip-file-error-running-command-had-status-127

# Zip the folders
## zip(zipfile = "filename.zip", files = "filename")
folder_names <- c("folder1", "folder2")
sapply(folder_names, function(x) zip(zipfile = paste0(x,".zip"), files = x))

# Create a folder
## dir.create("foldername", recursive=TRUE)
dir.create("zips", recursive=TRUE)

# Copy the files to the new folder
## file.copy(from = "filename", to = "foldername")
file.copy(from = paste0(folder_names, ".zip"), to = "zips")
# Remove the original files
## file.remove("filename")
file.remove(paste0(folder_names, ".zip"))

# Or move the files directly by renaming them.
## zip(zipfile = "filename.zip", files = "filename")
## file.rename(from = "filename",  to = "filenameAfter")
sapply(folder_names, function(x) zip(zipfile = paste0(x,".zip"), files =x))
file.rename(from = paste0(folder_names, ".zip"),  to = paste0("zips\\", folder_names, ".zip"))

# Unzip files
## unzip("filename.zip", exdir = "destination folder")
sapply(paste0("zips\\", folder_names, ".zip"), function(x) unzip(x, exdir = "zips"))
