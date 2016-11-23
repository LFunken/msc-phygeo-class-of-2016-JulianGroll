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

s1 <- stack(paste0(path_aerial_rs, "474000_5632000.tif"))
plot(s1)

red <- s1[[1]]
green <- s1[[2]]
blue <- s1[[3]]

blue

shape <- ((2*red)-green-blue)/(green-blue)

plot(shape)

