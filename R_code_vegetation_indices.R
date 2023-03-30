#Caluclating spectral indices

#Exercise: import defor1_.png
l1992<-brick("defor1_.png")
plot(l1992)

#Exercise: plot the image via plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
#What is NIR?
#NIR = 1
#RED = 2
#GREEN = 3

#Exercise: calculate DVI for 1992
dvi1992 = l1992[[1]] - l1992[[2]]
dvi1992

#Specifying a colour scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi1992, col=cl)

#Exercise: import defor2_.png
l2006<-brick("defor2_.png")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

#Exercise: plot the image from 1992 on top of that of 2006
par(mfrow=c(2,1)) 
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

#Exercise: plot the image from 1992 on the side of that of 2006
par(mfrow=c(1,2)) 
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

#NDVI1992

#Exercise: calculate DVI for 2006
dvi2006 = l2006[[1]] - l2006[[2]]
dvi2006

#Specifying a colour scheme
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) 
plot(dvi2006, col=cl)

#Multitemporal analysis
difdvi = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difdvi, col=cld)

#NDVI1992
ndvi1992 = dvi1992 / (l1992[[1]] + l1992[[2]])
plot(ndvi1992, col=cl)

#NDVI2006
ndvi2006 = dvi2006 / (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col=cl)

#Difference NDVI
difndvi = ndvi1992 - ndvi2006
plot(difndvi, col=cld)
