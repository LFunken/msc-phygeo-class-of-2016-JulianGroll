library(raster)
library(rgdal)
library(tools)
library(glcm)

rs_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/"
path_data_rs <- paste0(rs_base, "data/")
path_original_rs <- paste0(path_data_rs, "original/")
path_aerial_rs <- paste0(path_original_rs, "aerial/")
path_temp <- paste0(rs_base, "temp/")
rasterOptions(tmpdir = path_temp)

setwd("D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/data/original/aerial/")

# load rasterfiles

s1 <- raster(paste0(path_aerial_rs, "476000_5632000.tif"))



texture_1 <- glcm(s1, window = c(1, 1), statistics = c("contrast", "mean", "homogeneity"))

texture_2 <- glcm(s1, window = c(5, 5), statistics = c("contrast", "mean", "homogeneity"))

texture_3 <- glcm(s1, window = c(13, 13), statistics = c("contrast", "mean", "homogeneity"))

texture_4 <- glcm(s1, window = c(25, 25), statistics = c("contrast", "mean", "homogeneity"))

texture_5 <- glcm(s1, window = c(51, 51), statistics = c("contrast", "mean", "homogeneity"))

texture_6 <- glcm(s1, window = c(101, 101), statistics = c("contrast", "mean", "homogeneity"))

contrast_1_1 <- texture_1$glcm_contrast
contrast_5_5 <- texture_2$glcm_contrast
contrast_13_13 <- texture_3$glcm_contrast
contrast_25_25 <- texture_4$glcm_contrast
contrast_51_51 <- texture_5$glcm_contrast
contrast_101_101 <- texture_6$glcm_contrast

writeRaster(contrast_1_1, "contrast_1_1.tif", "GTiff")
writeRaster(contrast_5_5, "contrast_5_5.tif", "GTiff")
writeRaster(contrast_13_13, "contrast_13_13.tif", "GTiff")
writeRaster(contrast_25_25, "contrast_25_25.tif", "GTiff")
writeRaster(contrast_51_51, "contrast_51_51.tif", "GTiff")
writeRaster(contrast_101_101, "contrast_101_101.tif", "GTiff")

par(mfrow = c(3,2))

plot(texture_1$glcm_contrast)

plot(texture_2$glcm_contrast)

plot(texture_3$glcm_contrast)

plot(texture_4$glcm_contrast)

plot(texture_5$glcm_contrast)

plot(texture_6$glcm_contrast)


