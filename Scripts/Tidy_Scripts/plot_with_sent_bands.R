filter(sent_bands, nm > 1000)

ggplot(AW) +
  
  geom_tile(data = filter(sent_bands, Center_Wavelength_nm < 1000), aes(x = Center_Wavelength_nm, y = 0.2, height = Inf,
                                   width = Bandwidth_nm), fill = 'steelblue', alpha = 0.2) +
  geom_line(data = AW,aes(x = nm, y = refl,group= ID, colour = Tapping)) +
  theme_bw() +
  xlab('wavelength, nm') +
  ylab('Reflectance')

  #ggsave('./Figures/AW_sentBands_tapping.png', dpi = 600, width = 12)


ggplot(AW) +
  
  geom_tile(data = filter(sent_bands, Center_Wavelength_nm < 1000), aes(x = Center_Wavelength_nm, y = 0.2, height = Inf,
                                                                        width = Bandwidth_nm), fill = 'steelblue', alpha = 0.2) +
  geom_line(data = AW,aes(x = nm, y = refl,group= ID, colour = Device)) +
  theme_bw() +
  xlab('wavelength, nm') +
  ylab('Reflectance')

#ggsave('./Figures/AW_sentBands_Device.png', dpi = 600, width = 12)

ggplot(AW) +
  
  geom_tile(data = filter(sent_bands, Center_Wavelength_nm < 1000), aes(x = Center_Wavelength_nm, y = 0.2, height = Inf,
                                                                        width = Bandwidth_nm), fill = 'steelblue', alpha = 0.2) +
  geom_line(data = AW,aes(x = nm, y = refl,group= ID, colour = Tapping)) +
  theme_bw() +
  xlab('wavelength, nm') +
  ylab('Reflectance') +
  facet_wrap(~C_pos., nrow = 3)
#ggsave('./Figures/AW_sentBands_Tapping.canopy.png', dpi = 600, width = 8)

  #geom_vline(data = sent_bands,aes(xintercept = Center_Wavelength_nm))+
  #geom_vline(data = sent_bands,aes(xintercept = Center_Wavelength_nm+(0.5*Bandwidth_nm)), colour = 'steelblue') +
  #geom_vline(data = sent_bands,aes(xintercept = Center_Wavelength_nm-(0.5*Bandwidth_nm)), colour = 'steelblue')+
  
             #+
  facet_wrap(C_pos.~Tapping)


AW <- na.omit(AW)

glimpse(AW)

sent_bands <- data.frame(
  Band = c("B1", "B2", "B3", "B4", "B5", "B6", "B7", "B8", "B8A", "B9", "B10", "B11", "B12"),
  Center_Wavelength_nm = c(443, 490, 560, 665, 705, 740, 783, 842, 865, 945, 1375, 1610, 2190),
  Bandwidth_nm = c(20, 65, 35, 30, 15, 15, 20, 115, 20, 20, 30, 90, 180)
)
