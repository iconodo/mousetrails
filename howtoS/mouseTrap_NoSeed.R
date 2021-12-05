setwd("~/Documents/MuseScore3/Partituras/chuck/dasher/kadensze_sess1")

# comment / uncomment as desired one of next two code lines...
#ratonera <- read.table("out222.txt", header = TRUE, sep = ",") # Random seeded = 90
ratonera <- read.table("out223.txt", header = TRUE, sep = ",") # No seed
#... or run mouseTrap_RndSeed.R / mouseTrap_NoSeed-R ... accordingly

library(dplyr)
library(ggplot2)

#qplot(X, Y, data = ratonera, color = SYLLABLE)
qplot(X, -Y, data = ratonera, main = "Random: except Yield, map is always different", color = SYLLABLE)
qplot(cX, cY, data = ratonera, color = SYLLABLE)

qplot(dX, data = ratonera, color = SYLLABLE, geom = "density")
qplot(-dY, data = ratonera, color = SYLLABLE, geom = "density")

fray1 <- filter(ratonera, SYLLABLE == "FRAY 1")
qplot(dX, data = fray1, color = SYLLABLE, geom = "density")
qplot(-dY, data = fray1, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = fray1, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = fray1, color = SYLLABLE, geom = "line")

qplot(dX, -dY, data = fray1, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'


san2 <- filter(ratonera, SYLLABLE == "SAN- 2")
qplot(dX, data = san2, color = SYLLABLE, geom = "density")
qplot(-dY, data = san2, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = san2, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = san2, color = SYLLABLE, geom = "line")

qplot(dX, -dY, data = san2, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'


tia3 <- filter(ratonera, SYLLABLE == "-TIA- 3")
qplot(dX, data = tia3, color = SYLLABLE, geom = "density")
qplot(-dY, data = tia3, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = tia3, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = tia3, color = SYLLABLE, geom = "line")

qplot(dX, -dY, data = tia3, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'


go4 <- filter(ratonera, SYLLABLE == "GO 4")
qplot(dX, data = go4, color = SYLLABLE, geom = "density")
qplot(-dY, data = go4, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = go4, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = go4, color = SYLLABLE, geom = "line")

qplot(dX, -dY, data = go4, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'


fray5 <- filter(ratonera, SYLLABLE == "FRAY 5")
qplot(dX, data = fray5, color = SYLLABLE, geom = "density")
qplot(-dY, data = fray5, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = fray5, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = fray5, color = SYLLABLE, geom = "line")

san6 <- filter(ratonera, SYLLABLE == "SAN- 6")
qplot(dX, data = san6, color = SYLLABLE, geom = "density")
qplot(-dY, data = san6, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = san6, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = san6, color = SYLLABLE, geom = "line")

tia7 <- filter(ratonera, SYLLABLE == "-TIA- 7")
qplot(dX, data = tia7, color = SYLLABLE, geom = "density")
qplot(-dY, data = tia7, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = tia7, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = tia7, color = SYLLABLE, geom = "line")

go8 <- filter(ratonera, SYLLABLE == "GO 8")
qplot(dX, data = go8, color = SYLLABLE, geom = "density")
qplot(-dY, data = go8 , color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = go8, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = go8, color = SYLLABLE, geom = "line")

#qplot(dX, data = ratonera, color = "SYLLABLE", geom = "density" )
#qplot(-dY, data = ratonera, color = "SYLLABLE", geom = "density" )

#qplot(dX, WHEN, data = ratonera, color = SYLLABLE)
#qplot(-dY, WHEN, data = ratonera, color = SYLLABLE)

qplot(WHEN * 1000, dX, data = ratonera, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = ratonera, color = SYLLABLE, geom = "line")

qplot(WHEN * 1000, dX, data = ratonera, color = "SYLLABLE", geom = "line")
qplot(WHEN * 1000, -dY, data = ratonera, color = "SYLLABLE", geom = "line")


qplot(dX, -dY, data = ratonera, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'
 qplot(dX, -dY, data = ratonera, color = SYLLABLE, geom = c("line", "smooth"))
+ `geom_smooth()` using method = 'loess' and formula '-y ~ x'

 qplot(dX, -dY, data = fray1, color = SYLLABLE, geom = c("line", "smooth"))
 + `geom_smooth()` using method = 'loess' and formula '-y ~ x'
 
 
 summary(ratonera)

#ratonera <- read.table("out222.txt", header = TRUE, sep = ",")
abrat <- read.table("out222.txt", header = TRUE, sep = ",")
head(abrat)

abrat$dXabs = abs(ratonera$dX)
tail(abrat)

abrat$dYabs = abs(ratonera$dY)
tail(abrat)

abratAbsx <- sum(abrat$dXabs)
abratAbsx 

abratAbsy <- sum(abrat$dYabs)
abratAbsy 

manhatan <- abratAbsx + abratAbsy
manhatan

