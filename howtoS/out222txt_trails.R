## out222_RStudio.R
## a file with a "spasms" analyzed
## refer to file spasmO.pdf in below Google drive for a detailed explanation

## warning: comment lines are lead by two ##, code lines by one # (when commented)
## change names of working directories, dataframes, etc. as necessary

## check working directory 
getwd()

## change to your .txt files folder as required
## for example...
setwd("~/Documents/MuseScore3/Partituras/chuck/dasher/kadensze_sess1")

## out222.txt is the model for youTube video
## downloaded/download from next Google drive: 
## https://drive.google.com/drive/folders/1RYWdrHIWVvuZyS5GL8GB9O94jlNCsoN5?usp=sharing
## read into dataframe "ratonera"
ratonera <- read.table("out222.txt", header = TRUE, sep = ",") ## Random seeded = 90

library(dplyr)
library(ggplot2)
library(ggrepel)
set.seed(42)

## map of buttons / syllables of first song phrase repeated twice
## coordinates X,Y in the map mean the prompts/buttons deployed
qplot(X, -Y, data = ratonera, main = "Map is constantly the same if Random seeded", color = SYLLABLE)

## trails of random seeded excersise in out222.txt
## in "Yield" (fucsia) trail, chuck/miniAudicle window coordinates 0,0 mean wherever the mouse
## departs from in order to reach and click "Yield" button. All other trails are relative 
## to coordinates "Yield" was clicked. 
qplot(cX, cY, data = ratonera, main = "Trails from mouse position to next button click", color = SYLLABLE)

## simulated spasm in trail FRAY 1 extracted into dataframe "fray1"
fray1 <- filter(ratonera, SYLLABLE == "FRAY 1")

## first rows of both dataframes
head(ratonera)
head(fray1)

## next three exploratory commands show rows where spasm is encompassed
## cX,cY pairs show the trail coordinates, cumulative from dX,dY mouse movements magnitudes
## scroll down/up after next commands if not all rows are seen in the console
## or zoom out desktop as necessary
fray1[74:90,]
fray1[89:107,]
fray1[106:124,]

## row numbers (rownames) are necessary for spasm plot p
## array with fray1 rownumbers as names/chr
id <-rownames(fray1)
## append array as "id" column values; show result
fray1 <- cbind(id=id, fray1)
head(fray1)

## "spasm" region into dataframe fray13
fray13 <- filter(fray1, strtoi(id) >= 73 & strtoi(id) <= 106)

## plot the spasm into p
p <- ggplot(fray13, aes(x=cX, y=cY))+
        geom_count(mapping=aes(color=SYLLABLE))+
        geom_text_repel(aes(label=paste("(",cX,",",cY,id,")"),max.overlaps=25))

## display the plot...
## in order to properly see the plot, click zoom magnifying glass in the displayed graphic
## and alternatively render it in full screen fashion to follow the trail in detail
print(p)



## next plot is a nice solution I found in order to label points in previous graphic...
## posted to solve the problem posted in next link...
##https://stackoverflow.com/questions/45437815/geom-text-with-two-labels-in-ggplot-graph

## uncomment lines with one # in next section

#b <- data.frame(Group  = c("Expert Performers","Expert Performers","Expert Performers","Expert Performers","Non-Performers","Non-Performers","Non-Performers","Non-Performers"), 
#                Gaze.direction = c("game table","objects table","other","co-participant","game table","objects table","other","co-participant"), Counts = c(148,40,94,166,223,111,86,312), Duration =c(1262.122,139.466,371.191,387.228,1137.517,369.26,86.794,566.438))

#ggplot(b, aes(x=Group, y=Gaze.direction))+
#        geom_count(mapping=aes(color=Counts, size=Duration))+
#        theme_bw()+
# theme(panel.grid.major = element_line(colour = "grey"))+scale_size(range = c(0, 8))+
# scale_colour_gradient(low = "black", high = "gray91")+
# scale_y_discrete(name ="Gaze direction") + 
# geom_text(aes(label=paste("(",Counts,",",Duration,")"),hjust=-1, vjust=-1))



## alternatively, you can try next exploratory probes
## from which we don't have useful conclusions yet

qplot(dX, data = ratonera, color = SYLLABLE, geom = "density")
qplot(-dY, data = ratonera, color = SYLLABLE, geom = "density")
qplot(cX, cY, data = fray13, color = "FRAY 1" ,geom = "point" )
qplot(cX, cY, data = fray1, color = "FRAY 1" ,geom = c("point", "smooth") )
qplot(dX, data = fray1, color = SYLLABLE, geom = "density")
qplot(-dY, data = fray1, color = SYLLABLE, geom = "density")
qplot(WHEN * 1000, dX, data = fray1, color = SYLLABLE, geom="line")
qplot(WHEN * 1000, -dY, data = fray1, color = SYLLABLE, geom = "line")

qplot(dX, -dY, data = fray1, color = SYLLABLE, geom = c("point", "smooth")) 
+ `geom_smooth()` using method = 'loess' and formula 'y ~ x'


