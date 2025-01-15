# for plots of raw spectra before normalisations to absoloute refectance
source('./Scripts/Tidy_Scripts/PACKAGES.R')
source('./Scripts/Tidy_Scripts/FUNCTIONS.R')
source('./Scripts/Tidy_Scripts/func_read_site_data.R')
source('./Scripts/Tidy_Scripts/func_tidy_polypen_files.R')

#source('./Scripts/Read_site_data.R')
#source('./Scripts/Tidy_Polypen_Files.R')
#source('./Scripts/PACKAGES_FUNCTIONS.R')

ALL1 <-  bind_rows(tidy_polypen(DATA = fALLT1()))
ALL2 <-  bind_rows(tidy_polypen(DATA = fALLT2()))
ALL <- na.omit(bind_rows(ALL1, ALL2))
glimpse(ALL)




ggplot(ALL, aes(x = nm, y = refl, colour = Device, group = ID)) +
  geom_line(alpha = 0.7) +
  facet_wrap(~Location, scales = 'free_y') +
  theme_bw() +
  theme(aspect.ratio = 1)
#ggsave('./Figures/All_reflectance.png', dpi = 600, width = 16, units = 'cm', height = 14)

ggarrange(
ggplot(filter(ALL, Location == 'LLT-1' & Date == "2024-06-26"), aes(x = nm, y = refl, colour = Device, group = ID)) +
  geom_line(alpha = 0.7) +
  facet_wrap(~Location, scales = 'free_y') +
  annotate("text", x = 500, y=0.4, label = "2024-06-26") +
  theme_bw() +
  theme(aspect.ratio = 1) +
  theme(legend.position = 'none', aspect.ratio = 1),

ggplot(filter(ALL, Location == 'LLT-1' & Date == "2024-06-27"), aes(x = nm, y = refl, colour = Device, group = ID)) +
  geom_line(alpha = 0.7) +
  facet_wrap(~Location, scales = 'free_y') +
  annotate("text", x = 500, y=50, label = "2024-06-27") +
  theme_bw() +
  theme(aspect.ratio = 1) +
  theme(legend.position = 'none', aspect.ratio = 1))
#ggsave('./Figures/LLT-1_reflectance.png', dpi = 600, width = 12, units = 'cm', height = 6)


AW <- ALL %>% filter(Location == 'AW-1')
AWW <- AW %>% group_by(nm, Device) %>%
  summarise(refl = mean(refl))
ggplot(filter(ALL, Location == 'AW-1'), aes(x = nm, y = refl, colour = Device)) +
  geom_line(aes(group=ID), alpha = 0.1) +
  geom_line(data = AWW, aes(colour = Device, linetype = Device),size = 1) +
  scale_linetype_manual(values=c("longdash","solid"))+
  facet_wrap(~Location, scales = 'free_y') +
  #annotate("text", x = 500, y=50, label = "") +
  theme_bw() +
  theme(aspect.ratio = 1)
#ggsave('./Figures/AW-1_Device.png', dpi = 600, width = 10, units = 'cm', height = 8)


AW <- ALL %>% filter(Location == 'AW-1')
AWm <- AW %>% group_by(Tapping, nm, Device) %>%
  summarise(refl = mean(refl))

ggplot(AW, aes(x = nm, y = refl, colour = Tapping)) +
  geom_line(aes(group = ID), alpha = 0.1) +
  geom_line(data = AWm, aes(colour = Tapping, linetype = Device),size = 1) +
  scale_linetype_manual(values=c("longdash","solid"))+
  #annotate("text", x = 500, y=50, label = "") +
  theme_bw() +
  theme(aspect.ratio = 1) 

#ggsave('./Figures/AW1_Tapping.png', dpi = 600, width = 10, units = 'cm', height = 8)


AW <- ALL %>% filter(Location == 'AW-1')
AWmm <- AW %>% group_by(Tapping, C_pos., nm, Device) %>%
  summarise(refl = mean(refl))

ggplot(AW, aes(x = nm, y = refl, colour = C_pos.)) +
  geom_line(aes(group = ID), alpha = 0.1) +
  geom_line(data = AWmm, aes(colour = C_pos., linetype = Device)) +
  scale_linetype_manual(values=c("longdash","solid"))+
  facet_wrap(~Tapping)+
  #annotate("text", x = 500, y=50, label = "") +
  theme_bw() +
  theme(aspect.ratio = 1) 
#ggsave('./Figures/AW1_Canopy_pos.png', dpi = 600, width = 16, units = 'cm', height = 6)
