
shell('C:/OSGeo4W64/apps/saga/modules/ta_morphometry.dll -SLOPE = slpe -MINCURV = minimalcrv -MAXCURV = maximalcrv -PCURV = profile -TCURV = tangential -PLAIN = NULL -PIT = NULL -PEAK = NULL -RIDGE = NULL -CHANNEL = NULL -SADDLE = NULL -BSLOPE = NULL -FSLOPE = NULL -SSLOPE = NULL -HOLLOW = NULL -FHOLLOW = NULL -SHOLLOW = NULL -SPUR = NULL -FSPUR = NULL -SSPUR = NULL -FORM = NULL -MEM = NULL -ENTROPY = NULL -CI = NULL -SLOPETODEG = NULL -T_SLOPE_MIN = NULL -T_SLOPE_MAX = NULL -T_CURVE_MIN = NULL -T_CURVE_MAX = NULL)

slope <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/slope.tif"

maximalcrv <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/maximal.tif"

minimalcrv <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/minimal.tif"

profile <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/profile.tif"

tangential <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/tangential.tif"

output <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Advanced_GIS/data/gi-ws-03-1/plain2.sgrd"


system(abc)
system(paste0("C:/OSGeo4W64/apps/saga/saga_cmd.exe ta_morphometry 25 -SLOPE=",slope,
                                                                     " -MINCURV=" ,minimalcrv,
                                                                     " -MAXCURV=", maximalcrv, 
                                                                     " -PCURV=",profile, 
                                                                     " -TCURV=",profile,
                                                                     " -PLAIN=", output))
abc
shell(C:/OSGeo4W64/apps/saga/saga_cmd.exe)
"