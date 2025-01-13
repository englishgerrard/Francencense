library(ggpubr)

data <- AW
spatial_df <- st_as_sf(
  data,
  coords = c("lon", "lat"),
  crs = 4326
)  


ggplot(data = spatial_df ) +
  geom_raster(data = raster_df,aes(fill = B1,x = x,y=y))+
  geom_sf(aes(colour = Tree_ID)) +
  rremove('legend')

ggplot(data = spatial_df ) +
  geom_raster(data = raster_df,aes(fill = B2,x = x,y=y))+
  geom_sf(aes(colour = C_pos., shape = Tree_ID)) +
  scale_color_manual(values=c("#0077BB", "#009988", "#CC3311"))+
  rremove('legend') +
  xlim(c(36.3125, 36.315)) +
  ylim(c(12.695, 12.698))
  

#ggsave('./Figures/AW spatial.png', dpi = 900, width = 10)

#ggsave('./Figures/All_locations.png', dpi = 900, width = 10)
raster_df <- as.data.frame(rasterToPoints(sentinel_raster), xy = TRUE)

# Load the GeoTIFF file
sentinel_raster <- raster("./Data/Agamwuha_Sent2.tif")
sentinel_stack <- stack("./Data/Agamwuha_Sent2.tif")

# Reproject to EPSG:4326 if needed
sentinel_raster <- projectRaster(sentinel_stack, crs = CRS("+init=epsg:4326"))

# Plot the raster
plot(sentinel_raster, main = "Sentinel-2 Scene", col = terrain.colors(5),
     xlim = c(36.31, 36.315),
     ylim = c(12.694, 12.698))
#plot(spatial_df[,c(7)], add = T)
plot(spatial_df, add = F)
