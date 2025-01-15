# Plot both VI from PolyPen and manually calculate VI from interpolted data using
# func_calVI.R

source('./Scripts/Tidy_Scripts/.PACKAGES.R')
# function to calculate VI from spectra data
source('./Scripts/Tidy_Scripts/func_calcVI.R')

# read interpolated data
df <- read.csv('./Data/tidy_data/interpolated_D2.csv')
#run VI function
VI2 <- calcVI(df, keep_bands = F, Device2 = T)

# read, filter, and average PolyPen VI
ppVI2 <- read.csv('./Data/tidy_data/tidy_VI_data_D1_D2.csv') %>% 
  filter(Device == 'D2') %>%
  filter(Location == 'AW-1') %>%
  group_by(Location, Tapping, C_pos.) %>%
  summarise_each(mean, c('NDVI':'CRI2'))

# avaerage manually calc VI
VI2m <- VI2 %>% filter(Location == 'AW-1') %>%
  group_by(Location, Tapping, C_pos.) %>%
  summarise_each(mean, c('NDVI':'CRI2'))

# plot circles are manual VI and crosses are PolyPen VI
ggarrange(
ggplot(VI2m, aes(x= C_pos., y = NDVI, colour = Tapping)) +
geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab'),

ggplot(VI2m, aes(x= C_pos., y = SR, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,

ggplot(VI2m, aes(x= C_pos., y = MCARI, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = G, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = TCARI, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = SPRI, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = PRI, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = SIPI, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = ARI1, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = ARI2, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
ggplot(VI2m, aes(x= C_pos., y = CRI1, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') ,
  
ggplot(VI2m, aes(x= C_pos., y = CRI2, colour = Tapping)) +
  geom_point(shape = 1) +
  geom_point(data = ppVI2, shape = 3) +
  theme_bw() +
  rremove('legend') + 
  rremove('xlab') )

ggsave('./Figures/VI_comparison.png', dpi = 600, width = 16, height = 12, units = 'cm')
