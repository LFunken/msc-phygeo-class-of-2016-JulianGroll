library(raster)
library(rgdal)
library(tools)
library(glcm)

Sys.getenv("PATH")

saga_path <- '"C:/OSGeo4W64/apps/saga/saga_cmd.exe"'

saga_path

Sys.setenv(PATH=paste0(saga_path,":",Sys.getenv("PATH")))

Sys.getenv("PATH")

filepath_base<-gsub("\\\\", "/", path.expand(filepath_base))

# define pathes 
# TODO make it dynamic
filepath_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/"
path_data_da <- paste0(filepath_base, "Advanced_GIS/data/gi_ws_03_1/")
#path_aerial <- paste0(path_data, "aerial/")
#path_aerial_merged <- paste0(path_data, "aerial_merged/")
#path_aerial_croped <- paste0(path_data, "aerial_croped/")
#path_rdata <- paste0(path_data, "RData/")
#path_scripts <- paste0(filepath_base, "scripts/msc-phygeo-remote-sensing/src/functions/")
path_temp <- paste0(filepath_base, "temp/")

slope <- paste0(path_data_da, "slope.sdat")

maximalcrv <- paste0(path_data_da, "maxima.sdat")

minimalcrv <- paste0(path_data_da, "minimal.sdat")

profile <-  paste0(path_data_da, "profile.sdat")

tangential <- paste0(path_data_da, "tangential.sdat")

output <- paste0(path_data_da, "plain2.sgrd")

cmd <- paste0(saga_path,
              "ta_morphometry 25",
              " -SLOPE ", paste0(path_data_da, "slope.sgrd"),
              " -MINCURV ", paste0(path_data_da, "minimal.sgrd"),
              " -MAXCURV ", paste0(path_data_da, "maxima.sgrd"),
              " -PCURV ", paste0(path_data_da, "profile.sgrd"),
              " -TCURV ", paste0(path_data_da, "tangential.sgrd"),
              " -PLAIN ", paste0(path_data_da, "plain2.sgrd"),
              " -SLOPETODEG 0 -T_SLOPE_MIN 5.000000 -T_SLOPE_MAX 15.000000 -T_CURVE_MIN 0.000002 -T_CURVE_MAX 0.000050")

system(cmd)

system(abc)
