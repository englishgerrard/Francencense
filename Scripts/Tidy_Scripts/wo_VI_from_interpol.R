# Aim is to turn interpolated DATA into VI comparable with the polypen calculated 
# VI direct files
source('./Scripts/Tidy_Scripts/.PACKAGES.R')

df <- read.csv('./Data/tidy_data/interpolated_D2.csv')

calcVI <- function(data, keep_bands = T, Device2 = F){
oneBand <- data %>%
  filter(abs(nm - 800) == min(abs(nm - 800)))

oneBand$r430 <- filter(data,abs(nm - 430) == min(abs(nm - 430)))$refl
oneBand$r450 <- filter(data,abs(nm - 450) == min(abs(nm - 450)))$refl
oneBand$r510 <- filter(data,abs(nm - 510) == min(abs(nm - 510)))$refl
oneBand$r531 <- filter(data,abs(nm - 531) == min(abs(nm - 531)))$refl
oneBand$r550 <- filter(data,abs(nm - 550) == min(abs(nm - 550)))$refl
oneBand$r554 <- filter(data,abs(nm - 554) == min(abs(nm - 554)))$refl
oneBand$r570 <- filter(data,abs(nm - 570) == min(abs(nm - 570)))$refl
oneBand$r650 <- filter(data,abs(nm - 650) == min(abs(nm - 650)))$refl
oneBand$r670 <- filter(data,abs(nm - 670) == min(abs(nm - 670)))$refl
oneBand$r677 <- filter(data,abs(nm - 677) == min(abs(nm - 677)))$refl
oneBand$r680 <- filter(data,abs(nm - 680) == min(abs(nm - 680)))$refl
oneBand$r700 <- filter(data,abs(nm - 700) == min(abs(nm - 700)))$refl
oneBand$r790 <- filter(data,abs(nm - 790) == min(abs(nm - 790)))$refl
oneBand$r800 <- filter(data,abs(nm - 800) == min(abs(nm - 800)))$refl

if(Device2 == F){
oneBand$NDVI <- (oneBand$r790-oneBand$r670)/(oneBand$r790+oneBand$r670)
oneBand$SR <- oneBand$r800/oneBand$r670
if (keep_bands == T) {
  return(oneBand)}
if (keep_bands == F) {
  return(oneBand[,c(2:11, 25:27)])} 
}


if(Device2 == T){

oneBand$NDVI <- (oneBand$r790-oneBand$r670)/(oneBand$r790+oneBand$r670)
oneBand$SR <- oneBand$r800/oneBand$r670
oneBand$MCARI <- ((oneBand$r700- oneBand$r670) - 0.2 * (oneBand$r700- oneBand$r550)) * (oneBand$r700/ oneBand$r670)
oneBand$G <- oneBand$r554 / oneBand$r677
oneBand$TCARI <-  3 * ((oneBand$r700- oneBand$r670) - 0.2 * (oneBand$r700- oneBand$r550) * (oneBand$r700/ oneBand$r670))
oneBand$SRPI <- oneBand$r430 / oneBand$r680
oneBand$PRI <- (oneBand$r531-oneBand$r570)/(oneBand$r531+oneBand$r570)
oneBand$SIPI <- (oneBand$r790-oneBand$r450)/(oneBand$r790+oneBand$r650)
oneBand$ARI1 <- 1/oneBand$r550 - 1/oneBand$r700
oneBand$ARI2 <-oneBand$r800 * (1/oneBand$r550 - 1/oneBand$r700)
oneBand$CRI1 <- 1/oneBand$r510 - 1/oneBand$r550
oneBand$CRI2 <- 1/oneBand$r510 - 1/oneBand$r700 

if (keep_bands == T) {
  return(oneBand)}
if (keep_bands == F) {
  return(oneBand[,c(2:11, 25:37)])}
  }
}

calcVI(df, keep_bands = F, Device2 = T)

oneBand$CRI1 <- 1/oneBand$r510 – 1/oneBand$r550



VI2 <- calcVI(df)



#D1
NDVI
SR
OSAVI
TVI
ZMI
Ctr1
Ctr2
Lic1
GM2
CRI2
RDVI
#D2
NDVI
SR
MCARI1
OSAVI
G
MCARI
TCARI
TVI
ZMI
SPRI
NPQI
PRI
NPCI
Ctr1
Ctr2
Lic1
Lic2
SIPI
GM1
GM2
ARI1
ARI2
CRI1
CRI2
RDVI

