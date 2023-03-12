#My first code in Git Hub
#Let's install the raster package
install.packages("raster")
library(raster)

#settaggio cartella di lavoro
setwd("C:/lab/")

#import
l2011<-brick("p224r63__2011_masked.grd")
l2011

#plot
plot(l2011)

cl<-colorRampPalette(c(“red”, “orange”, “yellow”)) (100)
plot(l2011, col=cl)

plot(l2011[[4]], col=cl) o plot(l2011$B4_sre, col=cl)

nir<-l2011[[4]] or: nir<-l2011$B4_sre
plot(nir, col=cl)
