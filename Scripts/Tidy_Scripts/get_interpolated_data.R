source('./Scripts/Tidy_Scripts/.PACKAGES.R')

D1 <- read.csv('./Data/tidy_data/tidy_polypen_D1.csv')
D2 <- read.csv('./Data/tidy_data/tidy_polypen_D2.csv')

interpolate <- function(x){   
a <- interpolated_df[[x]]  
df <- data.frame(ID = unique(a$ID),
           nm =nm_seq,
           refl = approx(x = a$nm, y = a$refl,
                         xout = c(nm_seq))$y)
df$Tree_ID <- str_sub(df$ID, 1, -4)
df <- df %>%
  separate(ID, c('Location','site_num','Tapping', 'Tree_num', 'C_pos.', 'Device'), '-', remove = F)  
df$Location <- paste(df$Location, df$site_num, sep='-')
return(na.omit(df))}

interpolated_df <- D1 %>%
  group_by(ID) %>%
  group_split() 
nm_seq <- seq(from = 626, to =1059, by =1)   
in_df_D1 <- bind_rows(lapply(1:288, interpolate))
write.csv(in_df_D1, './Data/tidy_data/interpolated_D1.csv')

interpolated_df <- D2 %>%
  group_by(ID) %>%
  group_split() 
nm_seq <- seq(from = 323, to =793, by =1)   
in_df_D2 <- bind_rows(lapply(1:288, interpolate))

write.csv(in_df_D2, './Data/tidy_data/interpolated_D2.csv')
      

 