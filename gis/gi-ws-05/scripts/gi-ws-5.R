# load gdalUtils
library(gdalUtils)

saga_cmd <- '"C:/OSGeo4W64/apps/saga/saga_cmd.exe"'

saga_cmd

Sys.setenv(PATH=paste0(saga_cmd,":",Sys.getenv("PATH")))

Sys.getenv("PATH")

filepath_git<-"D:/Dokumente/Studium/Master_Marburg/msc-phygeo-class-of-2016-JulianGroll/"

# source the setPathGlobal function assumed to be in an already existing "fun" folder
source("D:/Dokumente/Studium/Master_Marburg/msc-phygeo-class-of-2016-JulianGroll/fun/setPathGlobal.R")

setPathGlobal
# call the setPathGlobal function
setPathGlobal(filepath_git)

# you can source all existing functions 
# first generate a list of all files you want to source
sourceFileNames <- list.files(pattern="[.]R$", path=paste0(filepath_git,"/fun"), full.names=TRUE)

# source them all
sapply(sourceFileNames, FUN=source)

system('saga_cmd ta_morphometry 25 
       -SLOPE=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/slope.sgrd
       -MINCURV=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/minimal.sgrd
       -MAXCURV=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/maximal.sgrd
       -PCURV=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/profile.sgrd 
       -TCURV=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/tangential.sgrd 
       -PLAIN=D:/Dokumente/Studium/Master_Marburg/data/gis/RData/gi-ws-03/plain.sgrd 
       [-PIT <str>] 
       [-PEAK <str>] 
       [-RIDGE <str>] 
       [-CHANNEL <str>] 
       [-SADDLE <str>] 
       [-BSLOPE <str>] 
       [-FSLOPE <str>] 
       [-SSLOPE <str>] 
       [-HOLLOW <str>] 
       [-FHOLLOW <str>] 
       [-SHOLLOW <str>] 
       [-SPUR <str>] 
       [-FSPUR <str>] 
       [-SSPUR <str>] 
       [-FORM <str>] 
       [-MEM <str>] 
       [-ENTROPY <str>] 
       [-CI <str>] 
       [-SLOPETODEG <str>] 
       [-T_SLOPE_MIN <str>] 
       [-T_SLOPE_MAX <str>] 
       [-T_CURVE_MIN <str>] 
       [-T_CURVE_MAX <str>]')