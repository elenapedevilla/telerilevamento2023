# R code for species distribution modelling

# install.packages("sdm")
# install.packages("rgdal", dependencies=T) # Serve per la gestione dei dati delle specie 

library(sdm)
library(raster) # Predictors; gestisce i preditori (= le variabili ambientabili), che sono dati raster (pixel)
library(rgdal) # Species; gestisce i punti, i dati in formato vettoriale (coordinate)

file <- system.file("external/species.shp", package="sdm") # In sdm c'è una cartella 'external'
file # Scrivendo file vediamo in che cartella il tutto si trova; abbiamo il path che ci porta al dato
species <- shapefile(file) # La funzione shapefile va a leggere lo shapefile che stiamo passando dal percorso che andiamo a spiegare al sistema; per utilizzare questa funzione ci serve la library raster

# Looking at the set
species
# In questo caso abbiamo 200 punti; datum = WGS84; variabili = occorenza = presenza di una certa specie; assenza = non presenza di una certa specie

# Plot
plot(species)
# Vediamo i 200 punti
plot(species, pch=19) # Così non abbiamo più la croce, ma un puntino

# Presences
presences <- species[species$Occurrence == 1,] # == 1 = prendiamo solo i punti che hanno un'occorenza (che valgono 1)
presences # Abbiamo solo 94 punti, visto che abbiamo solo le presenze
plot(presences, col="blue", pch=19)

# Absences
absences <- species[species$Occurrence == 0,] # == 0 = prendiamo solo i punti che hanno un'assenza (che valgono 0)
presences # 106 punti
plot(absences, col="red", pch=19)

# Plot together pres and abs
plot(species[species$Occurrence == 1,],col='blue',pch=16) # Plot solo delle presenze
points(species[species$Occurrence == 0,],col='red',pch=16) # Con la funzione points aggiungiamo il plot delle assenze
# Presenze di rana temporaria in pres e assenza di rana temporaria in abs

# Predictors: look at the path; predittori = variabili ambientali che ci serviranno per determinare la distribuzione della specie
path <- system.file("external", package="sdm")

# List the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T) # Pattern = andiamo a prendere i file che hanno questa estensione; full.names = True per vedere il nome intero
lst # Vediamo che abbiamo 4 dati all'interno di questa lista

# Stack (per mettere tutti i predittori insieme)
preds <- stack(lst) # Stack dei 4 dati raster)

# Plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)
# Elevation: zona sudest di più alta quota
# Precipitation: soprattutto nella zona di montagna, ma anche più a sud
# Temperature: naturalmente più bassa laddove la quota è più alta
# Vegetation: di meno laddove la quota è più alta


# Plot predictors and occurrences; plot di ogni singola variabile
plot(preds$elevation, col=cl)
points(presences, pch=19) # Stessa cosa: points(species[species$Occurrence == 1,], pch=19) 
# Vediamo che la rana non ama le alte quote

plot(preds$temperature, col=cl)
points(presences, pch=19)
# Preferisce zone con temperature più alte

plot(preds$precipitation, col=cl)
points(presences, pch=19)
# Ama zone umide

plot(preds$vegetation, col=cl) # Vegetation = copertura, biomassa della vegetazione
points(presences, pch=19)
# La specie ha bisogno di essere protetta (da volatili ecc.), quindi preferisce zone con vegetazione più alta, dentro la quale si può rifugiare


# Model; modello per prevedere la distribuzione della specie in zone in cui non abbiamo i dati (zone in cui non abbiamo campionato)
# £ passaggi principali:

# 1. Set the data for the sdm; spiegare al sistema quali sono i dati che andiamo ad utilizzare
datasdm <- sdmData(train=species, predictors=preds) # Train = dati a terra; predictors = predittori 

# Model
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

# Make the raster output layer
p1 <- predict(m1, newdata=preds)

# Plot the output
plot(p1, col=cl)
points(species[species$Occurrence == 1,], pch=16)

# Add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)

# Do you want to change names in the plot of the stack?
# Here your are!:
# Choose a vector of names for the stack, looking at the previous graph, qhich are:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
# And then replot!:
plot(s1, col=cl)
# You are done, with one line of code (as usual!)
