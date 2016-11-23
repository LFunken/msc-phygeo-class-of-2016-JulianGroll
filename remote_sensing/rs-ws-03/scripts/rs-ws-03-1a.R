library(raster)
library(rgdal)


rs_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/"
path_data_rs <- paste0(rs_base, "data/")
path_original_rs <- paste0(path_data_rs, "original/")
path_aerial_rs <- paste0(path_original_rs, "aerial/")
path_lidar_rs <- paste0(path_original_rs, "lidar/")
path_aerial_croped_rs <- paste0(path_data_rs, "aerial_croped/")
path_temp <- paste0(rs_base, "temp/")

rasterOptions(tmpdir = path_temp)

setwd("D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing")
# Raster einlesen (Bilder mit weißem Streifen)

s6 <- stack(paste0(path_aerial_rs, "476000_5632000_1.tif"))

s7 <- stack(paste0(path_aerial_rs, "476000_5632000.tif"))

s_neu2 <- s6+s7-255

plotRGB(s_neu2)

writeRaster(s_neu2, "bearbeitet2.tif", "GTiff")