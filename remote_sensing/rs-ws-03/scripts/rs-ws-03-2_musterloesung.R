library(raster)
library(tools)




rs_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Remote_Sensing/"
path_temp <- paste0(rs_base, "temp/")
path_data_rs <- paste0(rs_base, "data/")
path_original_rs <- paste0(path_data_rs, "original/")
path_aerial_rs <- paste0(path_original_rs, "aerial/")
path_lidar_rs <- paste0(path_original_rs, "lidar/")
path_aerial_croped_rs <- paste0(path_data_rs, "aerial_croped/")
path_scripts <- paste0(rs_base, "scripts/")
rasterOptions(tmpdir = path_temp)


source(paste0(path_scripts, "fun_ngb_aerials.R")) # Load functions from scripts


#Gibt benachbarte Dateinamen aus: Nord, Ost, Süd, West
#Einlesereihenfolge: Oben-links, Unten-links, Oben-mitte, Unten-mitte, Oben-rechts, Unten-rechts
files <- c("474000_5632000.tif", "474000_5630000.tif", "476000_5632000.tif",
           "476000_5630000.tif", "478000_5632000.tif", "478000_5630000.tif")
neighbors <- ngb_aerials(files, step = 2000)


#########################################################

result <- numeric()
res1 <- list()
res2 <- list()
res3 <- list()
res4 <- list()
res5 <- list()
res6 <- list()
res_list <- list(res1, res2, res3, res4, res5, res6)

i <- 1
j <- 2


#Alle 6 Raster durchzählen
for(i in 1:6){   # oder statt 1:6 length(liste in die man alle bilder davorgepackt hat)
  #Erster Raster Einlesen # "center" weils die kachel in der mitte ist um die man die nachbarn sucht
  center <- stack(paste0(path_aerial_rs, files[i]))
  #Grenzen berechnen
  c_top <- center[1,]
  c_right <- center[,ncol(center)] # den maximalwert der reihe
  c_down <- center[nrow(center),]  # den maximalwert der zeilen
  c_left <- center[,1]
  c_border <- list(c_top, c_right, c_down, c_left)  # alles in liste gepackt
  
  
  #Alle vier Seiten durchtesten
  for(j in 1:4){
    #Nachbarraster einlesen
    #Prüfen ob im aktuellen Schleifendurchgang ein Nachbarraster vorhanden ist
    if(!is.na(neighbors[[i]][j])){   # i steht für die liste mit nachbarn(6 stück) und j für die vier werte die drin stehen
                                       # und alle NA werte werden gleich gar nicht mitgerechnet
      
      neighbor <- stack(paste0(path_aerial_rs, neighbors[[i]][j]))
      #Nachbargrenzen berechnen
      n_down <- neighbor[nrow(neighbor),]
      n_left <- neighbor[,1]
      n_top <- neighbor[1,]
      n_right <- neighbor[,ncol(neighbor)]
      n_border <- list(n_down, n_left, n_top, n_right) # andere reihenfolge (was bei der einen kachel oben ist, ist bei der anderen logischerweise unten)
      
      #richtige Linie Extrahieren
      c_line <- c_border[[j]]
      n_line <- n_border[[j]]
      
      #Histogram ertellen und counts Vergleichen: Je mehr Nullen oder kleine Werte im Ergebnis desto ähnlicher die beiden Raster
      #ERSTEZEN DURCH VARIANZANALYSE?
      c_hist <- hist(c_line, breaks = seq(0,255,5))
      n_hist <- hist(n_line, breaks = seq(0,255,5))
      result <- c_hist$counts - n_hist$counts
      
      #Ergebnisse speichern
      res_list[[i]][[j]] <- result
    }else{
      res_list[[i]][[j]] <- NA
    }
  }
}

########################################################################
saveRDS(res_list, file = paste0(rs_base, "rs-ws-03-2_results.rds"))



##########Statistische Tests
df_c <- as.data.frame(c_line)
df_n <- as.data.frame(n_line)
df_c$raster <- as.factor("c")
df_n$raster <- "n"
colnames(df_c) <- c("R","G","B","raster")
colnames(df_n) <- c("R","G","B","raster")
df_anova <- rbind(df_c, df_n)
df_anova$raster <- as.factor(df_anova$raster)
t.test(df_anova$R~ df_anova$raster)

?anova
hist(df_n[,1])