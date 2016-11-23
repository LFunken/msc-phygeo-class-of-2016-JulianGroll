split_place <- function(df){
  
  Ort <- strsplit(as.character(df$Place), ",") # Komma als Spaltentrenner setzen (eine Spalte wird in mehrere Spalten aufgeteilt)
  
  place_df <- lapply(Ort, function(i){
    p1 <- sub("^\\s+", "", i[1]) #Führende Leerzeichen löschen
    if(length(i) > 2){
      p2 <- sub("^\\s+", "", i[2])
      p3 <- sub("^\\s+", "", i[3])
    } else if (length(i) > 1){
      p2 <- sub("^\\s+", "", i[2])
      p3 <- NA
    } else {
      p2 <- NA
      p3 <- NA
    }
    data.frame(A = p1,
               B = p2,
               C = p3)
  })
  place_df <- do.call("rbind", place_df) #"rbind" = Rowbind
  
  unique(place_df[, 2]) #Gibt einzigartige Werte für die zweite Spalte aus
  unique(place_df$B[!is.na(place_df$C)])
  
  place_df$ID <- df$ID
  
  place_df$Year <- df$Year
  
  names(place_df) <- c("Place", "Admin_unit", "Admin_misc", "ID", "Year") # spalten neu benennen
         
  place_df[! is.na(place_df$Admin_misc),] < place_df[!is.na(place_df$Admin_misc), c(1,3,2,4,5)] #2te und dritte Spalte tauschen
         
  for (r in seq(nrow(place_df))){
    if (is.na(place_df$Admin_unit[r]) &
      grepl("kreis", tolower(place_df$Place[r]))){
     place_df$Admin_unit[r] <- "Landkreis"
   }
 }
    
  place_df$Admin_unit[is.na(place_df$Admin_unit) & nchar(as.character(place_df$ID) == 2)] <- "Bundesland" 
  
  place_df$Admin_unit[place_df$ID == "DG"] <- "Land"#Alle "NA"-Einträge in B, deren entsprechender Eintrag in der ID 2 Zeichen aufweist, wurden in "Bundesland" umgewandelt. 
  # Der Eintrag in B, für den in ID "DG" angegeben ist, wurde in "Land" umgewandelt.
  
  place_df <- place_df[,c(4,5,1,2,3)] # spalten tauschen
  
  place_df <- cbind(place_df, df[,4:ncol(df)]) #geänderten dataframe in ursprünglichen table eingliedern
  
  return(place_df)    
}
