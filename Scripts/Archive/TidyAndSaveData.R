# tidy the data and create files
source('./Scripts/Read_site_data.R')
source('./Scripts/Tidy_Polypen_Files.R')
source('./Scripts/PACKAGES_FUNCTIONS.R')

ALLD1 <-  bind_rows(tidy_polypen(DATA = fALLT1()))
ALLD2 <-  bind_rows(tidy_polypen(DATA = fALLT2()))

ALL <- bind_rows(ALLD1,ALLD2)

write.csv(ALLD1, './Data/TidyD1all.csv')
write.csv(ALLD2, './Data/TidyD2all.csv')
write.csv(ALL, './Data/TidyALL.csv')
