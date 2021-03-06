# gi-ws-04-1 plain plateau reloaded
#
# using system() to operate the SAGA Shell


# initialise the script and save all filepaths in a list
source("D:/Dokumente/Studium/Master_Marburg/msc-phygeo-class-of-2016-JulianGroll/fun/Init.R")
path <- Init("gi", "04")


# execute SAGA modul 'Slope, Aspect, Curvature'
# set path to the input data caldern_DEM.sdat
setwd(path$rs$saga)

DEM <- raster("caldern_DEM.tif")
plot(DEM)
ksize <- 3
DEM_focal <- focal(DEM, w=matrix(1, nc=ksize, nr=ksize), fun=modal, na.rm = TRUE, pad = TRUE)
plot(DEM_focal)

writeRaster(DEM_focal, "caldern_filter_DEM.tif")


# execute modul with unit_slope = 0 (radian)
# don't forget Space after each text fragment to separate arguments
system(paste0("saga_cmd ta_morphometry 0 ",
              "-ELEVATION=caldern_filter_DEM.sdat ",
              "-SLOPE=slope_fil ",
              "-ASPECT=aspect_fil ",
              "-C_PROF=profil_fil ",
              "-C_TANG=tangential_fil ",
              "-C_MINI=minimum_fil ",
              "-C_MAXI=maximum_fil ",
              "-METHOD=6 -UNIT_SLOPE=0 -UNIT_ASPECT=0"))


# execute SAGA modul 'Fuzzy Landform Element Classification'
# SLOPETODEG=1 because slope unit is radian
parameter_default <- "-T_SLOPE_MIN=5.000000 -T_SLOPE_MAX=15.000000 -T_CURVE_MIN=0.000002 -T_CURVE_MAX=0.000050"

# getting good results with these parameters:
parameter <- "-T_SLOPE_MIN=5.000000 -T_SLOPE_MAX=15.000000 -T_CURVE_MIN=0.0007 -T_CURVE_MAX=0.15"


system(paste0("saga_cmd ta_morphometry 25 ",
              "-SLOPE=slope_fil.sdat ",
              "-MINCURV=minimum_fil.sdat ",
              "-MAXCURV=maximum_fil.sdat ",
              "-PCURV=profil_fil.sdat ",
              "-TCURV=tangential_fil.sdat ",
              "-PLAIN=class_plain_fil ",
              "-FORM=class_landform_fil ",
              "-MEM=class_membership_fil ",
              "-ENTROPY=class_entropy_fil ",
              "-CI=class_confusion_fil ",
              "-SLOPETODEG=1 ",
              parameter))

# convert output to .tif
system("saga_cmd io_gdal 2 -GRIDS=class_plain_fil.sdat -FILE=class_plain_fil.tif")
system("saga_cmd io_gdal 2 -GRIDS=class_landform_fil.sdat -FILE=class_landform_fil.tif")

########## End of command line part ############

library(raster)
library(glcm)

# initialise the script and save all filepaths in a list
source("D:/Dokumente/Studium/Master_Marburg/msc-phygeo-class-of-2016-JulianGroll/fun/Init.R")
path <- Init("gi", "04")

# show results
plains <- raster(paste0(path$rs$saga, "class_plain_fil.tif"))
plot(plains)


# glcm mean to get rid of some artefacts
plains_mean <- plains
plot(plains_mean)

# reclassify all values from 0.7 to 1 as 1
plains_reclass <- reclassify(plains_mean, matrix(c(0.7,1,1)))
plot(plains_reclass)

# reclassify as plain or plateau using the DEM
plains_reclass_backup <- plains_reclass
DEM <- raster(paste0(path$rs$aerial, "caldern_DEM.tif"))

# Bei H�hen gr��er 250m Plateau; darunter Plain
plains_reclass[plains_reclass_backup == 1 & DEM < 250] <- 1
plains_reclass[plains_reclass_backup == 1 & DEM >= 250] <- 2

# Gelb: Plateau, Gr�n: Plain
plot(plains_reclass)
writeRaster(plains_reclass, "plain_early_filter.tif")