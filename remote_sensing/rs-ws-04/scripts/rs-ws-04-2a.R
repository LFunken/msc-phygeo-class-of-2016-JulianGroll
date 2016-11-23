library(raster)
library(rgdal)
library(tools)
library(glcm)

rs_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/"
path_data_rs <- paste0(rs_base, "data/")
path_original_rs <- paste0(path_data_rs, "original/")
path_aerial_rs <- paste0(path_original_rs, "aerial/")
path_lidar_rs <- paste0(path_original_rs, "lidar/")
path_aerial_croped_rs <- paste0(path_data_rs, "aerial_croped/")
path_temp <- paste0(rs_base, "temp/")
rasterOptions(tmpdir = path_temp)

setwd("D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/data/original/aerial/")

# load rasterfiles

s1 <- stack(paste0(path_aerial_rs, "474000_5630000.tif"))
s2 <- stack(paste0(path_aerial_rs, "474000_5632000.tif"))
s3 <- stack(paste0(path_aerial_rs, "476000_5630000.tif"))
s4 <- raster(paste0(path_aerial_rs, "476000_5632000.tif"))
s5 <- stack(paste0(path_aerial_rs, "478000_5630000.tif"))
s6 <- stack(paste0(path_aerial_rs, "478000_5632000.tif"))


texture_1 <- glcm(s4, window = c(1, 1), statistics = c("contrast", "mean", "homogeneity"))

texture_2 <- glcm(s4, window = c(5, 5), statistics = c("contrast", "mean", "homogeneity"))

texture_3 <- glcm(s4, window = c(13, 13), statistics = c("contrast", "mean", "homogeneity"))

texture_4 <- glcm(s4, window = c(25, 25), statistics = c("contrast", "mean", "homogeneity"))

texture_5 <- glcm(s4, window = c(51, 51), statistics = c("contrast", "mean", "homogeneity"))

texture_6 <- glcm(s4, window = c(101, 101), statistics = c("contrast", "mean", "homogeneity"))

homogeneity_1_1 <- texture_1$glcm_homogeneity
homogeneity_5_5 <- texture_2$glcm_homogeneity
homogeneity_13_13 <- texture_3$glcm_homogeneity
homogeneity_25_25 <- texture_4$glcm_homogeneity
homogeneity_51_51 <- texture_5$glcm_homogeneity
homogeneity_101_101 <- texture_6$glcm_homogeneity

writeRaster(homogeneity_1_1, "homogeneity_1_1.tif", "GTiff")
writeRaster(homogeneity_5_5, "homogeneity_5_5.tif", "GTiff")
writeRaster(homogeneity_13_13, "homogeneity_13_13.tif", "GTiff")
writeRaster(homogeneity_25_25, "homogeneity_25_25.tif", "GTiff")
writeRaster(homogeneity_51_51, "homogeneity_51_51.tif", "GTiff")
writeRaster(homogeneity_101_101, "homogeneity_101_101.tif", "GTiff")

plot(texture_1$glcm_mean)

plot(texture_2$glcm_mean)

plot(texture_3$glcm_mean)

plot(texture_4$glcm_mean)

plot(texture_5$glcm_mean)

plot(texture_6$glcm_mean)

par(mfrow = c(3,2))



texture <- glcm(raster(s1, layer = 3))

plot(texture$glcm_mean)