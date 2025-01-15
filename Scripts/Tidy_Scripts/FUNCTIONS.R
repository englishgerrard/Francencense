# file list functions
all_files <- list.files('./PolyPen/PolyPen_Data/', recursive = TRUE, full.names = TRUE)
file_list <- all_files[!grepl('Revised', basename(all_files))]
file_D1 <- file_list[!grepl('D2', basename(file_list))]
file_D2 <- file_list[!grepl('D1', basename(file_list))]

file_VI <- all_files[grepl('Revised', basename(all_files))]
file_VI_D1 <- file_list[!grepl('D2', basename(file_VI))]
file_VI_D2 <- file_list[!grepl('D1', basename(file_VI))]
