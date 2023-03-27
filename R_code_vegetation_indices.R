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
