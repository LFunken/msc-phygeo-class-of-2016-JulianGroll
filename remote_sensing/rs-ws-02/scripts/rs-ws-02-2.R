library(raster)
library(rgdal)


rs_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/"
path_data_rs <- paste0(rs_base, "data/")
path_original_rs <- paste0(path_data_rs, "original/")
path_aerial_rs <- paste0(path_original_rs, "aerial/")
path_lidar_rs <- paste0(path_original_rs, "lidar/")
path_aerial_croped_rs <- paste0(path_data_rs, "aerial_croped/")
path_temp <- paste0(rs_base, "temp/")

# Luftbild 1(s1) und 2(s2) reinladen

s1 <- stack(paste0(path_aerial_rs, "478000_5632000.tif"))

s2 <- stack(paste0(path_aerial_rs, "478000_5630000.tif"))

# Lidar_Datensatz (lidar1) reinladen

lidar1 <- stack(paste0(path_lidar_rs, "geonode_las_intensity_05.tif"))

lidar1

# Bild S1 zuschneiden

s1_croped <- crop(s1, extent(478000,479000,5632000,5634000))

# Bild S2 zuschneiden

s2_croped <- crop(s2, extent(478000,479000,5630000,5632000))

# Bild S1 speichern

writeRaster(s1_croped, "478000_5632000", "GTiff")

writeRaster(s2_croped, "478000_5630000", "GTiff")


