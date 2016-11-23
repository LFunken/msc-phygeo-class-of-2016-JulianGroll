source("D:/BEN/msc-phygeo/msc-phygeo-git/gis/functions/source.R")

# Compute
dem_fp <- paste0(path_lidar_derivates, "DEM.tif")

# Transform tif to sgrd
cmd <- paste0(path_saga,
              " io_gdal 0",
              " -GRIDS ", paste0(dem_fp, ".sgrd"),
              " -FILES ", dem_fp)
system(cmd)


# Compute slope
cmd <- paste0(path_saga,
              " ta_morphometry 0",
              " -ELEVATION ", paste0(dem_fp, ".sgrd"),
              " -SLOPE ", paste0(path_lidar_derivates, "SLOPE.sgrd"))
cmd
system(cmd)

# Convert restult to tif
outfile <- paste0(path_lidar_derivates, "SLOPE.sgrd")
outfile <- paste0(substr(outfile, 1, nchar(outfile)-4), "tif")

cmd <- paste0(path_saga,
              " io_gdal 2",
              " -GRIDS ", paste0(path_lidar_derivates, "SLOPE.sgrd"),
              " -FILE ", outfile)
cmd
system(cmd)