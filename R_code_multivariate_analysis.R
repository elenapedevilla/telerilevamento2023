# How to reduce multidimensional dataset

library(raster)
library(ggplot2)
library(viridis)
setwd("C:/lab/") 

sen <- brick("sentinel.png")

sen
plot(sen)

sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])

plot(sen2)

pairs(sen2)

# PCA (Principal Component Analysis)
sample <- sampleRandom(sen2, 10000)
sample
pca <- prcomp(sample)

# Variance explained
summary(pca)

# Correlation with original bands
pca

# Pc map
pci <- predict(sen2, pca, index=c(1:2))

plot(pci[[1]])

# Ggplot
pcid <- as.data.frame(pci[[1]], xy=T)

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis()


# Speeding up analyses
# Aggregate cells: resampling (ricampionamento)
senres <- aggregate(sen, fact=10)

# Then repeat the PCA analysis
