library(raster)
library(glcm)

# initialise the script and save all filepaths in a list
source("D:/Dokumente/Studium/Master_Marburg/msc-phygeo-class-of-2016-JulianGroll/fun/Init.R")
path <- Init("gi", "04")

# show results
plains <- raster(paste0(path$rs$saga, "class_plain.tif"))
plot(plains)


# glcm mean to get rid of some artefacts
msize <- 5
plains_mean <- focal(plains, w=matrix(1, nc=msize, nr=msize), fun=modal, na.rm = TRUE, pad = TRUE)
plot(plains_mean)

# reclassify all values from 0.7 to 1 as 1
plains_reclass <- reclassify(plains_mean, matrix(c(0.7,1,1)))
plot(plains_reclass)

# reclassify as plain or plateau using the DEM
plains_reclass_backup <- plains_reclass
DEM <- raster(paste0(path$rs$aerial, "caldern_DEM.tif"))

# Bei Höhen größer 250m Plateau; darunter Plain
plains_reclass[plains_reclass_backup == 1 & DEM < 250] <- 1
plains_reclass[plains_reclass_backup == 1 & DEM >= 250] <- 2

# Gelb: Plateau, Grün: Plain
plot(plains_reclass)
writeRaster(plains_reclass, "plain_late_filter.tif")