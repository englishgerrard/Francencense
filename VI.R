source('./Scripts/PACKAGES_FUNCTIONS.R')


df <- bind_rows(lapply(1:24, function(x){
  df <-as.data.frame(t(na.omit(read.csv(file_VI[x], skip = 14,nrows = 27,header = F))))
  names(df) <- df[1,]
  df <- df[-1,]
  return(df)}))

pad_fourth_element <- function(str) {
  gsub("(.*-)(\\d)(-.*)", "\\1\\02\\3", str)
}


df$Date <- as.Date(str_sub(df$Time, 0,10), format = '%d/%m/%Y')
df$Datetime <- as_datetime(df$Time, format = '%d/%m/%Y %H:%M')
df$ID <- df$Name
df$ID2 <- pad_fourth_element(df$ID)
df$Tree_ID <- str_sub(df$ID, 1, -4)
df$Coordinates = df$GPS
df <- df %>%
  separate(ID, c('Location','site_num','Tapping', 'Tree_num', 'C_pos.', 'Device'), '-', remove = F)  
df$Location <- paste(df$Location, df$site_num, sep='-')
df <- df %>% mutate_at(c('NDVI', 'PRI', 'CRI1', 'ARI1', 'MCARI1','OSAVI'), as.numeric)

ggplot(df,aes(x=Datetime, y = as.numeric(PRI), shape = C_pos., colour = Device )) +
  geom_point() #

  facet_wrap(~C_pos.)
df %>% mutate(across(NDVI:CRI2), as.numeric) %>% str()
  
df_mean <- df %>%  group_by(Location, Tapping, Device) %>%
  summarise(across(c(NDVI,PRI,CRI1,ARI1,MCARI1,OSAVI), ~ mean(.x, na.rm = F))) %>%
 filter(Location != 'Repeatition-NA')



ggplot(df_mean, aes(x = Tapping, y = MCARI1, colour = Tapping, shape = Device)) +
  geom_point()




