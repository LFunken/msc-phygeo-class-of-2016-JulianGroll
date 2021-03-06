library(raster)

saga_cmd <- "C:/SAGA/saga_cmd.exe "

Sys.setenv("PATH"=paste("C:\\SAGA\\", Sys.getenv("PATH"), sep=";"))

path_input <- "C:/Users/Marius/Documents/Uni/Master/WS_1617/log_mog/data/gis/input/"
path_output <- "C:/Users/Marius/Documents/Uni/Master/WS_1617/log_mog/data/gis/output/"



dem <- paste0(path_input, "geonode_las_dtm_01.tif ")

cmd <- paste0(saga_cmd,
              "io_gdal 0 ",
              "-GRIDS ", paste0(path_output, "dem.sgrd "),
              "-FILES " , dem)
system(cmd)


cmd <- paste0(saga_cmd,
              "ta_morphometry 0 ",
              "-ELEVATION ", paste0(path_output, "dem.sgrd "),
              "-SLOPE ", paste0(path_output, "slope.sgrd "),
              "-C_MINI ", paste0(path_output, "minicurv.sgrd "),
              "-C_MAXI ", paste0(path_output, "maxicurv.sgrd "),
              "-C_PROF ", paste0(path_output, "profile.sgrd "),
              "-C_TANG ", paste0(path_output, "tangential.sgrd "),
              "-UNIT_SLOPE 1")

system(cmd)

cmd<- paste0(saga_cmd,
             "ta_morphometry 25 ",
             "-SLOPE ", paste0(path_output, "slope.sgrd "),
             "-MINCURV ", paste0(path_output, "minicurv.sgrd "),
             "-MAXCURV ", paste0(path_output, "maxicurv.sgrd "),
             "-PCURV ", paste0(path_output, "profile.sgrd "),
             "-TCURV ", paste0(path_output, "tangential.sgrd "),
             "-PLAIN ", paste0(path_output, "PLAIN4.sgrd "),
             "-FORM ", paste0(path_output, "form.sgrd "),
             "-MEM ",  paste0(path_output, "membership.sgrd "),
             "-ENTROPY ", paste0(path_output, "entropy.sgrd "),
             "-CI ", paste0(path_output, "CI.sgrd "),
             "-SLOPETODEG 0 ",
             "-T_SLOPE_MIN=3.000000 -T_SLOPE_MAX=10.000000 -T_CURVE_MIN=0.002 -T_CURVE_MAX=0.2")

system(cmd)

outfile <- paste0(path_output, "PLAIN4.sgrd")
outfile <- paste0(substr(outfile, 1, nchar(outfile)-4), "tif")


cmd <- paste0(saga_cmd,
              "io_gdal 2 ",
              "-GRIDS ", paste0(path_output, "PLAIN4.sgrd "),
              "-FILE ", outfile)

system(cmd)

plain4 <- raster(paste0(path_output, "PLAIN4.tif"))

