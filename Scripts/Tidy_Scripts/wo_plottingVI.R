source('./Scripts/Read_site_data.R')
source('./Scripts/Tidy_Polypen_Files.R')
source('./Scripts/PACKAGES_FUNCTIONS.R')


AW <- bind_rows(tidy_polypen(DATA = fAW1()),
                 tidy_polypen(DATA = fAW2()))
AW1 <-  bind_rows(tidy_polypen(DATA = fAW1()))

ALL1 <-  bind_rows(tidy_polypen(DATA = fALLT1()))
ALL2 <-  bind_rows(tidy_polypen(DATA = fALLT2()))

AW2 %>% filter(nm == )

AW1 <- ALL %>% filter(Location== 'AW-1')


oneBand <- AW2 %>%
  filter(abs(nm - 800) == min(abs(nm - 800)))
oneBand$r550 <- filter(AW2,abs(nm - 550) == min(abs(nm - 550)))$refl
oneBand$r670 <- filter(AW2,abs(nm - 670) == min(abs(nm - 670)))$refl
oneBand$r790 <- filter(AW2,abs(nm - 790) == min(abs(nm - 790)))$refl

oneBand1 <- AW1 %>%
  filter(abs(nm - 800) == min(abs(nm - 800)))
oneBand1$r550 <- filter(AW1,abs(nm - 550) == min(abs(nm - 550)))$refl
oneBand1$r670 <- filter(AW1,abs(nm - 670) == min(abs(nm - 670)))$refl
oneBand1$r790 <- filter(AW1,abs(nm - 790) == min(abs(nm - 790)))$refl

oneBandA1 <- ALL1 %>%
  filter(abs(nm - 800) == min(abs(nm - 800)))
oneBandA1$r550 <- filter(ALL1,abs(nm - 550) == min(abs(nm - 550)))$refl
oneBandA1$r670 <- filter(ALL1,abs(nm - 670) == min(abs(nm - 670)))$refl
oneBandA1$r790 <- filter(ALL1,abs(nm - 790) == min(abs(nm - 790)))$refl

oneBandA2 <- ALL2 %>%
  filter(abs(nm - 800) == min(abs(nm - 800)))
oneBandA2$r550 <- filter(ALL2,abs(nm - 550) == min(abs(nm - 550)))$refl
oneBandA2$r670 <- filter(ALL2,abs(nm - 670) == min(abs(nm - 670)))$refl
oneBandA2$r790 <- filter(ALL2,abs(nm - 790) == min(abs(nm - 790)))$refl

### VI
oneBandA1$MCARI1 <- 1.2*(2.5*(oneBandA1$r790-oneBandA1$r670) - 1.3*(oneBandA1$r790-oneBandA1$r550))
oneBandA1$NDVI <- (oneBandA1$r790-oneBandA1$r670)/(oneBandA1$r790+oneBandA1$r670)
oneBandA1$OSAVI <- (1 + 0.16) * (oneBandA1$r790 - oneBandA1$r670) / (oneBandA1$r790 - oneBandA1$r670 + 0.16)
oneBandA2$MCARI1 <- 1.2*(2.5*(oneBandA2$r790-oneBandA2$r670) - 1.3*(oneBandA2$r790-oneBandA2$r550))
oneBandA2$NDVI <- (oneBandA2$r790-oneBandA2$r670)/(oneBandA2$r790+oneBandA2$r670)
oneBandA2$OSAVI <- (1 + 0.16) * (oneBandA2$r790 - oneBandA2$r670) / (oneBandA2$r790 - oneBandA2$r670 + 0.16)

o <- oneBandA1 %>% group_by(Tapping,Device, Location) %>%
  summarise(across(c(MCARI1,NDVI,OSAVI), ~ mean(.x, na.rm = F))) %>%
  na.omit()
o2 <-oneBandA2 %>% group_by(Tapping,Device, Location) %>%
  summarise(across(c(NDVI,MCARI1,OSAVI), ~ mean(.x, na.rm = F))) %>%
  na.omit() 

o2[o2 == 'D'] <- 'D2'

ggplot(o, aes(x = Tapping, y = NDVI, shape = Device)) +
  geom_point(colour = 'red') +
  geom_point(data = o2, colour ='red') +
  geom_point(data = df_mean, colour = 'blue') +
  facet_wrap(~Location) +
  theme(aspect.ratio = 1)

#ggsave('./Figures/NDVIcomparsion.png', dpi = 900, width =10)

ggplot(o, aes(x = Tapping, y = MCARI1, shape = Device)) +
  geom_point(colour = 'red') + # red is my calculated values
  geom_point(data = o2, colour ='red') +
  geom_point(data = df_mean, colour = 'blue') + # device
  facet_wrap(~Location) +
  ylim(0,1)

#ggsave('./Figures/MCARI1comparsionZoom.png', dpi = 900, width =10)

ggplot(o, aes(x = Tapping, y = OSAVI, shape = Device)) +
  geom_point(colour = 'red') + # red is my calculated values
  geom_point(data = o2, colour ='red') +
  geom_point(data = df_mean, colour = 'blue') + # device
  facet_wrap(~Location)# +
  ylim(0,1)

  #ggsave('./Figures/OSAVIcomparsion.png', dpi = 900, width =10)
