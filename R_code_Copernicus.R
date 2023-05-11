# R code for downloading and visuailzing Copernicus in R

library(raster)

install.packages("ncdf4")
library(ncdf4)
library(ggplot2)
library(viridis)
setwd("C:/lab/")

# register and download data from:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

ssoil <- raster("C:/lab/c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")

ssoil

plot(ssoil)

ggplot() +
+ geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))

# with viridis
ggplot() +
geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
scale_fill_viridis(option="magma")
