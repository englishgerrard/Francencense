# tidy the data and create files
source('./Scripts/Tidy_Scripts/PACKAGES.R')
source('./Scripts/Tidy_Scripts/FUNCTIONS.R')
source('./Scripts/Tidy_Scripts/func_read_site_data.R')
source('./Scripts/Tidy_Scripts/func_tidy_polypen_files.R')

ALLD1 <-  bind_rows(tidy_polypen(DATA = fALLT1()))
ALLD2 <-  bind_rows(tidy_polypen(DATA = fALLT2()))

ALL <- bind_rows(ALLD1,ALLD2)

write.csv(ALLD1, './Data/TidyD1all.csv')
write.csv(ALLD2, './Data/TidyD2all.csv')
write.csv(ALL, './Data/TidyALL.csv')
