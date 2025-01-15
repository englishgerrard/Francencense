## chnage 
filt <- filter(ALL1, nm %in% c(626.5, 855.9, 1059))
ggplot(filt, aes(x = Datetime, y = refl, shape = Location, colour = Tapping)) +
  geom_point() +
  facet_wrap(~nm)

ggsave('./Figures/ObservationsOverTime.png', dpi = 600, width = 16, units = 'cm')

unique(ALL1$nm)


filt <- filter(ALL1, nm %in% c(626.5))
ggplot(filter(filt, Type != 'Dark'), aes(x = Datetime, y = Tapping, shape = Location, colour = Type)) +
  geom_point() +
  facet_wrap(~Date, scales = 'free_x')

ggsave('./Figures/WhiteRefTimings.png', dpi = 600, width = 16, units = 'cm')

glimpse(filt)
