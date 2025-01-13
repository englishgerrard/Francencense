tidy_polypen <- function(DATA=DATA){

SortPolypen <- function(data = data, x){
  data.frame(Date = as.Date(str_sub(data[1,x], 0,10), format = '%d/%m/%Y'),
             Datetime = as_datetime(data[1,x], format = '%d/%m/%Y %H:%M'),
             ID = data[2,x],
             Tree_ID = str_sub(data[2,x], 1, -4),
             Coordinates = data[3,x],
             Type = data[4,x],
             Signal = as.numeric(data[-c(1:4),x]),
             nm = as.numeric(data[-c(1:4),1]),
             obv_n = x) %>%
    separate(ID, c('Location','site_num','Tapping', 'Tree_num', 'C_pos.', 'Device'), '-', remove = F)}  

# Run the SortPolypen function over full dataset to transfrom and tidy
# lapply works from obs 2 to ignore the first column containing 
# the band length

long_data <- bind_rows(lapply(2:ncol(DATA), SortPolypen, data=DATA))
long_data$Tree_num <- as.numeric(long_data$Tree_num)
long_data$Location <- paste(long_data$Location, long_data$site_num, sep='-')
pad_fourth_element <- function(str) {
  gsub("(.*-)(\\d)(-.*)", "\\1\\02\\3", str)
}

long_data$ID2 <- pad_fourth_element(long_data$ID)
# plot
p1 <- ggplot(long_data, aes(x=nm,y=Signal,colour=Type, group = obv_n)) +
      geom_line()

### Seperate the specral observations into types 
# and store the obvs_number of each 
tran <- unique(filter(long_data,Type =='Transmitance')$obv_n)
dark_ref <- unique(filter(long_data,Type =='Dark')$obv_n)
white_ref <- unique(filter(long_data,Type =='Reference')$obv_n)

# these functions find the closest (one before) dark or ref observation to
# any given trans observation (NUM) and are used in the function below
NUM = 61
dark_ref[dark_ref < tran[NUM]][which.min(abs(dark_ref[dark_ref < tran[NUM]] - tran[NUM]))]
white_ref[dark_ref < tran[NUM]][which.min(abs(white_ref[white_ref < tran[NUM]] - tran[NUM]))]

# cairries out the filter outlined above and filters the relvent dark or white (ref) reference
# and the time these references were taken
match_observations <- function(x){
  data.frame(obv_n = tran[x],                                            
             nm = filter(long_data,obv_n == 2)$nm,
             dark_ref = filter(long_data, obv_n == dark_ref[dark_ref < tran[x]][which.min(abs(dark_ref[dark_ref < tran[x]] - tran[x]))] )$Signal,
             white_ref = filter(long_data, obv_n == white_ref[white_ref < tran[x]][which.min(abs(white_ref[white_ref < tran[x]] - tran[x]))])$Signal,
             dark_time = filter(long_data, obv_n == dark_ref[dark_ref < tran[x]][which.min(abs(dark_ref[dark_ref < tran[x]] - tran[x]))] )$Datetime,
             white_time = filter(long_data, obv_n == white_ref[white_ref < tran[x]][which.min(abs(white_ref[white_ref < tran[x]] - tran[x]))])$Datetime)}

# pull out the white/ dark reference dataset
references <- bind_rows(lapply(1:length(tran),match_observations))

# filter the Transmitance data
t <- filter(long_data,Type =='Transmitance')

# join the references to the transmittance data 
data <- full_join(t, references, by = c('obv_n', 'nm'))
# create absolute reflectance 
data <- data %>% mutate(refl = (Signal-dark_ref)/(white_ref-dark_ref)) %>%
  mutate(refl2 = Signal/white_ref)

p2 <- ggplot(data, aes(x= nm, y = refl, group = ID, colour = Tapping)) +
  geom_line() #+
  ylim(0, 1)

p3 <- ggplot(data, aes(x = nm, group = ID)) +
  geom_line(aes(y = Signal), colour = 'red') +
  geom_line(aes(y = dark_ref)) +
  geom_line(aes(y = white_ref), colour = 'blue') +
  facet_wrap(~Location*C_pos.)

############################# add spatial components ######################


# extract the degree and min then add together then divided by 60
lat <- as.numeric(str_replace_all(str_split_i(data$Coordinates, " ",1), "[^[:alnum:]]", "")) +
  as.numeric(str_sub(str_split_i(data$Coordinates, " ",2),1,-2))/60
# extract lat direction (N or S)
latDir <- str_split_i(data$Coordinates, " ", 3)
lon <- as.numeric(str_replace_all(str_split_i(data$Coordinates, " ",5), "[^[:alnum:]]", "")) +
  as.numeric(str_sub(str_split_i(data$Coordinates, " ",6),1,-2))/60
lonDir <- str_split_i(data$Coordinates, " ", 7)

data <- data %>% mutate(lat = ifelse(latDir == 'S', -lat, lat)) %>%
  mutate(lon = ifelse(latDir == 'W', -lon, lon))

 
return(data)}

