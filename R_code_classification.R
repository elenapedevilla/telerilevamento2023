# Classification of remote sensing data

library(raster)

setwd("C:/lab/")

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")

plotRGB(so, 1, 2, 3, stretch="lin")
plotRGB(so, 1, 2, 3, stretch="hist")

# Classifying the solar data

# https://rspatial.org/raster/rs/4-unsupclassification.html

# 1. Get all the single values
singlenr <- getValues(so)
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# Class 3: highest energy level
# Class 1: lowest energy level
# Class 2: medium energy level

frequencies <- freq(soclass)
frequencies
tot = 2221440
percentages = frequencies * 100 /  tot

# Class 3: highest energy level: 21.2%
# Class 1: lowest energy level: 41.4%
# Class 2: medium energy level: 37.3%


# set.seed can be used for repeating the experiment in the same manner for N times
# http://rfunction.com/archives/62



# Grand Canyon exercise

library(raster)

setwd("C:/lab/")

gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

# Red = 1
# Green = 2
# Blue = 3

plotRGB(gc, r=1, g=2, b=3, stretch="lin")

# Change the stretch to histogram stretching
plotRGB(gc, r=1, g=2, b=3, stretch="hist")

# The image is quite big; let's crop it
gcc <- crop(gc, drawExtent())
gcc 
plotRGB(gcc, r=1, g=2, b=3, stretch="lin")
ncell(gcc)

# Classification

# 1. Get values
singlenr <- getValues(gcc)
singlenr

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)
kcluster

# 3. Set values
gccclass <- setValues(gcc[[1]], kcluster$cluster) # Assign new values to a raster object
gccclass

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(gccclass, col=cl)

# Class 1: conglomerates
# Class 2: volcanic rocks
# Class 3: sandstone

frequencies <- freq(gccclass)
frequencies
tot = ncell(gccclass)
tot
percentages = frequencies * 100 /  tot
percentages
