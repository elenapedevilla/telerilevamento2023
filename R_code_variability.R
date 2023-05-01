# How to measure landscape variabililty with R

library(raster)
library(RStoolbox) # For image viewing and variability calculation
library(ggplot2) # For ggplot plotting
library(patchwork) # Multiframe with ggplot2 graphs

install.packages("viridis")
library(viridis)

setwd("C:/lab/") 

# Exercise: import the Similaun image
sen <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

# Exercise: plot the image by the ggRGB function
plotRGB(sen, 1, 2, 3, stretch="lin")

# NIR on g component
plotRGB(sen, 2, 1, 3)

# Calculation of variability over NIR --> standard deviation on the NIR band
nir <- sen[[1]]
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd)
plot(sd3)

clsd <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100)
plot(sd3, col=clsd)

# Plotting with ggplot
sd3d <- as.data.frame(sd3, xy=T)
sd3d

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer))

# With viridis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

# Cividis
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "cividis") +
ggtitle("Standard deviation by viridis package")

# Magma
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

# Inferno
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

# Patchwork
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation by viridis package")

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "inferno") +
ggtitle("Standard deviation by viridis package")

p1 + p2
