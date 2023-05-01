# My first code in Git Hub
# Let's install the raster package
install.packages("raster")
library(raster)

# Settaggio cartella di lavoro
setwd("C:/lab/")

# Import
l2011<-brick("p224r63_2011_masked.grd")
l2011

# Plot
plot(l2011)

cl<-colorRampPalette(c("red", "orange", "yellow"))(100)
plot(l2011, col=cl)

plot(l2011[[4]], col=cl) or plot(l2011$B4_sre, col=cl)

nir<-l2011[[4]] or: nir<-l2011$B4_sre
plot(nir, col=cl)

# Exercise: change the colour gamut for all the images (another range of colours, not red, orange, yellow)

# Exercise: plot the NIR band (only the 4th one, like last time)

# dev.off() closes graphs

# Export graphs in R
pdf("myfirstgraph.pdf")
plot(l2011$B4_sre, col=cl)
dev.off()

# Plotting two bands in a multiframe
par(mfrow=c(2,1)) 
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Plotting the first four bands/layers in a multiframe
par(mfrow=c(2,2))

# Blue
clb<-colorRampPalette(c("blue4", "blue2", "light blue"))(100)
plot(l2011[[1]], col=clb)

# Green
clg<-colorRampPalette(c("chartreuse4", "chartreuse3", "chartreuse"))(100)
plot(l2011[[2]], col=clg)

# Red
clr<-colorRampPalette(c("brown", "brown1", "darkred"))(100)
plot(l2011[[3]], col=clr)

# Infrared
cln<-colorRampPalette(c("darkorcihd", "darkorchid3", "darkorchid4"))(100)
plot(l2011[[4]], col=cln)

# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe with natural and false colours
par(mfrow=c(2,1)) 
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Histogram stretching
par(mfrow=c(2,1)) 
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Linear vs. Histogram stretching
par(mfrow=c(2,1)) 
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Exercise: plot the NIR band
plot(l2011[[4]])

# Exercise: import the 1988 image
l1988<-brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space the 1988 image (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")

# Exercise: plot in RGB space the 1988 image (false colour)
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Lin")

# Multiframe (natural colours)
par(mfrow=c(2,1)) 
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")

# Multiframe (false colours)
par(mfrow=c(2,1)) 
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Multiframe with 4 images (lin and histogram, 1988 and 2011)
par(mfrow=c(2,2)) 
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")
