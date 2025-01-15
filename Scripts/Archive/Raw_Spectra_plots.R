# for plots of raw spectra before normalisations to absoloute refectance

source('./Scripts/Tidy_Scripts/.PACKAGES.R')
source('./Scripts/Tidy_Scripts/.FUNCTIONS.R')
source('./Scripts/Tidy_Scripts/func_read_site_data.R')
source('./Scripts/Tidy_Scripts/func_tidy_polypen_files.R')

ALL1 <-  bind_rows(tidy_polypen(DATA = fALLT1()))
ALL2 <-  bind_rows(tidy_polypen(DATA = fALLT2()))
AW1 <- bind_rows(tidy_polypen(DATA = fAW1()))
AW2 <- bind_rows(tidy_polypen(DATA = fAW2()))
DG1 <- bind_rows(tidy_polypen(DATA = fDG1()))
DG2 <- bind_rows(tidy_polypen(DATA = fDG2()))
LT11 <- bind_rows(tidy_polypen(DATA = fLT11()))
LT21 <- bind_rows(tidy_polypen(DATA = fLT21()))
LT12 <- bind_rows(tidy_polypen(DATA = fLT12()))
LT22 <- bind_rows(tidy_polypen(DATA = fLT22()))

ALLraw <- bind_rows(ALL1, ALL2)
glimpse(ALL2)

ggarrange(
ggplot(AW2, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
  geom_line() +
  theme_bw()+
  theme(legend.position = 'none', aspect.ratio = 1),

ggplot(AW1, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
  geom_line() +
  theme_bw()+
  theme(legend.position = 'none', aspect.ratio = 1))
#ggsave('./Figures/AW-1_rawSpectra.png', dpi = 600, width = 12, units = 'cm')

ggarrange(
  ggplot(DG2, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1),
  
  ggplot(DG1, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1))
#ggsave('./Figures/DG-1_rawSpectra.png', dpi = 600, width = 12, units = 'cm')

ggarrange(
  ggplot(LT12, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1),
  
  ggplot(LT11, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1))
#ggsave('./Figures/LT-1_rawSpectra.png', dpi = 600, width = 12, units = 'cm')

ggarrange(
  ggplot(LT22, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1),
  
  ggplot(LT21, aes(x = nm, y = Signal, colour = Type, group = obv_n)) +
    geom_line() +
    theme_bw()+
    theme(legend.position = 'none', aspect.ratio = 1))
#ggsave('./Figures/LT-2_rawSpectra.png', dpi = 600, width = 12, units = 'cm')

