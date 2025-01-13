# the munually combined Agamwuha D1 (NIR 626-1059 nm) data 
AW1 <- read.csv('./PolyPen/PolyPen_Data/Agamwuha_all_D1.csv', header = FALSE)

# function to transfrom data to long format
# this seperates ID into components
# works column by column (note: obv_n tracks the order)
SortPolypen <- function(data = data, x){
  data.frame(Date = as.Date(str_sub(data[1,x], 0,10), format = '%d/%m/%Y'),
             Datetime = as_datetime(data[1,x], format = '%d/%m/%Y %H:%M'),
             ID = data[2,x],
             Coordinates = data[3,x],
             Type = data[4,x],
             Signal = as.numeric(data[-c(1:4),x]),
             nm = as.numeric(data[-c(1:4),1]),
             obv_n = x) %>%
    separate(ID, c('Location','var1','Tapping', 'var3', 'C_pos.', 'Device'), '-', remove = F)}  

# Run the SortPolypen function over full dataset to transfrom and tidy
# lapply works from obs 2 to ignore the first coloum containing 
# the band length
long_data <- bind_rows(lapply(2:ncol(AW1), SortPolypen, data=AW1))

### Seperate the specral observations into types 
# and store the obvs_number of each 
tran <- unique(filter(long_data,Type =='Transmitance')$obv_n)
dark_ref <- unique(filter(long_data,Type =='Dark')$obv_n)
white_ref <- unique(filter(long_data,Type =='Reference')$obv_n)

# these functions find the closest (one before) dark or ref observation to
# any given trans observation (NUM) and are used in the function below
NUM = 10
dark_ref[dark_ref < tran[NUM]][which.min(abs(dark_ref[dark_ref < tran[NUM]] - tran[NUM]))]
white_ref[white_ref < tran[NUM]][which.min(abs(white_ref[white_ref < tran[NUM]] - tran[NUM]))]

# cairries out the filter outlined above and filters the relvent dark or white (ref) reference
# and the time these references were taken
match_observations <- function(x){
  data.frame(obv_n = tran[x],                                            
             nm = filter(long_data,obv_n ==2)$nm,
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
data <- data %>% mutate(refl = (Signal-dark_ref)/(white_ref-dark_ref))

ggplot(data, aes(x= nm, y = refl, group = ID, colour = Tapping)) +
  geom_line()

ggplot(data, aes(x = nm, group = ID)) +
  geom_line(aes(y = Signal), colour = 'red') +
  geom_line(aes(y = dark_ref)) +
  geom_line(aes(y = white_ref), colour = 'blue')

m <- data %>% group_by(Tapping, nm) %>%
  summarise(ref = mean(refl))

ggplot(m, aes(x= nm, y = ref, colour = Tapping)) +
  geom_line()
