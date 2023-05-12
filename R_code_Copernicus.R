# R code for downloading and visuailzing Copernicus in R

library(raster)

# install.packages("ncdf4")
library(ncdf4)
library(ggplot2)
library(viridis)
setwd("C:/lab/")

# register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

ssoil <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

ssoil

plot(ssoil)
# In questo caso abbiamo delle strisciate di una parte del Sudamerica, una parte dell'Africa e una parte dell'Europa centrale

scd <- as.data.frame(ssoil, xy=T) # Trasformazione del dato raster in un dato continuo tabellare
# Alcune parti hanno un valore NA -> abbiamo delle parti con nessun valore, si vede anche dalle strisciate: non sono continue

ggplot() +
geom_raster(scd, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) # Il nome del layer (Surface.Soil.Moisture) si trova semplicemente scrivendo ssoil
ggtitle("Soil Moisture from Copernicus")

# Cropping an image (diverso dall'ultima volta, in quanto lo facciamo sulla base delle coordinate, non tramite un ritaglio diretto sull'immagine; questa modalità è molto più precisa)
# Guardando l'immagine (il plot) decidiamo come/dove fare il crop: vogliamo la parte europea
ext <- c(23, 30, 62, 68) # (x minima, x massima, y minima, y massima)
sc.crop <- crop(ssoil, ext) # Crop dell'immagine ssoil con l'estensione definita sopra
plot(sc.crop) # Vediamo il plot dell'immagine ritagliata

# Exercise: plot via ggplot image the cropped image 
sc.crop.d <- as.data.frame(sc.crop, xy=T)
head(sc.crop.d) # Ci fa vedere le prime sei righe
names(sc.crop.d) #  Ci fa vedere direttamente i nomi

ggplot() +
geom_raster(sc.crop.d, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
ggtitle("Cropped Soil Moisture from Copernicus")
scale_fill_viridis(option="cividis")
