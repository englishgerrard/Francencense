source('./Scripts/Read_site_data.R')
source('./Scripts/Tidy_Polypen_Files.R')
source('./Scripts/PACKAGES_FUNCTIONS.R')

ALL <- read.csv('./Data/TidyALL.csv')

ALL <- na.omit(ALL)

o <- ALL %>% filter(Date < '2024-06-27') %>%
  group_by(Location, Device, Tapping,nm) %>%
  summarise(m_refl = mean(refl))

#ggplot(ALL, 
ggplot(filter(ALL, Date < '2024-06-27'),
       aes(x = nm, y = refl, colour = Device, group= ID)) +
  geom_line()+
  facet_wrap(~Location, scales = 'free_y')

#ggsave('./Figures/Inital_Reflacance_goodsite.png', dpi = 600, width = 10, height = 6)

unique(ALL$Date)

#ggplot(o, 
ggplot(filter(o, Location == 'AW-1'),       
       aes(x = nm, y = m_refl, colour = Tapping, linetype = Device)) +
  geom_line() +
  theme_bw()#+
  facet_wrap(~C_pos.)
#ggsave('./Figures/Inital_Reflacance_AVE.png', dpi = 600, width = 8, height =8 )
