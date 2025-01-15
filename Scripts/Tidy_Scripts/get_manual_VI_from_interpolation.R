source('./Scripts/Tidy_Scripts/.PACKAGES.R')
# function to calculate VI from spectra data
source('./Scripts/Tidy_Scripts/func_calcVI.R')

# read interpolated data
df1 <- read.csv('./Data/tidy_data/interpolated_D1.csv')
df2 <- read.csv('./Data/tidy_data/interpolated_D2.csv')
#run VI function
VI1 <- calcVI(df, keep_bands = F, Device2 = F)
VI2 <- calcVI(df, keep_bands = F, Device2 = T)

write.csv(VI1, './Data/tidy_data/manual_VI_D1.csv')
write.csv(VI2, './Data/tidy_data/manual_VI_D2.csv')
