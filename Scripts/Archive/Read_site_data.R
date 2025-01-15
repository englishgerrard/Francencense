#Prep all

#Agamwuha
# Agamwuha D1

fAW1 <- function(){bind_cols(read.csv(file_D1[3], header = FALSE)[-1,],
                 read.csv(file_D1[1], header = FALSE),
                 read.csv(file_D1[2], header = FALSE))}

fAW2 <- function(){bind_cols(read.csv(file_D2[3], header = FALSE)[-1,],
                 read.csv(file_D2[1], header = FALSE),
                 read.csv(file_D2[2], header = FALSE))}

# Das Gundo
fDG1 <- function(){bind_cols(read.csv(file_D1[3], header = FALSE)[-1,1],
                 read.csv(file_D1[6], header = FALSE),
                 read.csv(file_D1[4], header = FALSE),
                 read.csv(file_D1[5], header = FALSE))}

fDG2 <- function(){bind_cols(read.csv(file_D2[3], header = FALSE)[-1,1],
                 read.csv(file_D2[6], header = FALSE),
                 read.csv(file_D2[4], header = FALSE),
                 read.csv(file_D2[5], header = FALSE))}


# Lemlem Terara 1
fLT11 <- function(){bind_cols(read.csv(file_D1[3], header = FALSE)[-1,1],
                 read.csv(file_D1[9], header = FALSE),
                 read.csv(file_D1[7], header = FALSE),
                 read.csv(file_D1[8], header = FALSE))}

fLT12 <- function(){bind_cols(read.csv(file_D2[3], header = FALSE)[-1,1],
                  read.csv(file_D2[9], header = FALSE),
                  read.csv(file_D2[7], header = FALSE),
                  read.csv(file_D2[8], header = FALSE))}


# Lemlem Terara 2
fLT21 <- function(){bind_cols(read.csv(file_D1[3], header = FALSE)[-1,1],
                  read.csv(file_D1[12], header = FALSE),
                  read.csv(file_D1[10], header = FALSE),
                  read.csv(file_D1[11], header = FALSE))}

fLT22 <- function(){bind_cols(read.csv(file_D2[3], header = FALSE)[-1,1],
                  read.csv(file_D2[12], header = FALSE),
                  read.csv(file_D2[10], header = FALSE),
                  read.csv(file_D2[11], header = FALSE))}


fALLT1 <- function(){bind_cols(read.csv(file_D1[3], header = FALSE)[-1,],
                   read.csv(file_D1[1], header = FALSE),
                   read.csv(file_D1[2], header = FALSE),
                   
                   read.csv(file_D1[9], header = FALSE),
                   read.csv(file_D1[7], header = FALSE),
                   read.csv(file_D1[8], header = FALSE),
                   
                   read.csv(file_D1[12], header = FALSE),
                   read.csv(file_D1[10], header = FALSE),
                   read.csv(file_D1[11], header = FALSE),
                   
                   read.csv(file_D1[6], header = FALSE),
                   read.csv(file_D1[4], header = FALSE),
                   read.csv(file_D1[5], header = FALSE)
                   )}

fALLT2 <- function(){bind_cols(read.csv(file_D2[3], header = FALSE)[-1,],
                               read.csv(file_D2[1], header = FALSE),
                               read.csv(file_D2[2], header = FALSE),
                               
                               read.csv(file_D2[9], header = FALSE),
                               read.csv(file_D2[7], header = FALSE),
                               read.csv(file_D2[8], header = FALSE),
                               
                               read.csv(file_D2[12], header = FALSE),
                               read.csv(file_D2[10], header = FALSE),
                               read.csv(file_D2[11], header = FALSE),
                               
                               read.csv(file_D2[6], header = FALSE),
                               read.csv(file_D2[4], header = FALSE),
                               read.csv(file_D2[5], header = FALSE)
)}