#Prospectr

library(prospectr)
# add some noise
noisy <- NIRsoil$spc + rnorm(length(NIRsoil$spc), 0, 0.001) 
# Plot the first spectrum
plot(x = as.numeric(colnames(NIRsoil$spc)),
     y = noisy[1, ],
     type = "l",
     lwd = 1.5,
     xlab = "Wavelength", 
     ylab = "Absorbance") 
X <- movav(X = noisy, w = 11) # window size of 11 bands
# Note that the 5 first and last bands are lost in the process
lines(x = as.numeric(colnames(X)), y = X[1,], lwd = 1.5, col = "red")
grid()
legend("topleft", 
       legend = c("raw", "moving average"), 
       lty = c(1, 1), col = c("black", "red"))

### 
spec <- filter(AW2, ID == 'AW-02-T-03-T-D2')
spec2 <- filter(AW1, ID == 'AW-02-T-03-T-D1')
# add a moving average (smoothed line)
spec$smR <- c(rep(spec[1,19],5),movav(X = spec$refl, w = 11),rep(spec[nrow(spec),19],5))

plot(x = spec$nm, y = spec$smR,type = 'l')
plot(x = spec$nm, y = spec$refl,type = 'l', add = T)
plot(x = spec$nm, y = spec$sgf,type = 'l')

# p = polynomial order w = window size (must be odd) m = m-th derivative (0 =
# smoothing) The function accepts vectors, data.frames or matrices.  For a
# matrix input, observations should be arranged row-wise
spec$sgf <- c(rep(spec[1,19],5),savitzkyGolay(X = spec$refl, p = 3, w = 11, m = 0),rep(spec[nrow(spec),19],5))
sg <- savitzkyGolay(X = NIRsoil$spc, p = 3, w = 11, m = 0)
# note that bands at the edges of the spectral matrix are lost !



spec$d1 <- c(0,diff(spec$refl, differences = 1)) # first derivative
spec$d2 <- c(0,0,diff(spec$refl, differences = 2)) # second derivative

plot(x = spec$nm, y = spec$d1,type = 'l')

AW <- bind_rows(spec, spec2)


