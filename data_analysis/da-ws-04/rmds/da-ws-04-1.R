da_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Data_Analysis/"
da_data <- paste0(da_base, "da-ws-04-1/")
da_scripts <- paste0(da_base, "scripts/")

feldfr <- read.table(paste0(da_data, "115-46-4_feldfruechte.txt"), skip = 7, header = FALSE, sep = ";", dec = ",", fill = TRUE, encoding = "ANSI") #"fill"-Funktion und "encoding" nicht vergessen

head(feldfr)#Zeigt die ersten 6 Zeilen und den Header ab

str(feldfr)#Ruft Datenstruktur ab

tail(feldfr)#Zeigt die letzten 6 Zeilen

#neue Namen
names(feldfr) <- c("Year", "ID", "Place", "Winter_wheat", "Rye", "Winterbarley", "Spring_barley", "Oat", "Triticale", "Potatos", "Suggar_beets", "Rapessed", "Silage_maize")

feldfr <- feldfr[1:8925,]#Löscht die Zeilen, welche nach der 8925ten Zeile kommen würden, nach dem Komma, nach 8925 werden die Spalten angegeben.
# Wenn man "1" eintippen würde, würde alles, außer der ersten Spalte gelöscht werden

tail(feldfr)

for(c in colnames(feldfr)[4:13]){
  feldfr[, c][feldfr[, c] == "." |
                 feldfr[, c] == "-" |
                 feldfr[, c] == "," |
                 feldfr[, c] == "/"] <- NA
  feldfr[, c] <- as.numeric(sub(",", ".", as.character(feldfr[, c])))
}  # Erst einzeln stehende Zeichen durch gültiges "NA" ersetzen. Dann Komma durch Punkt tauschen, dabei werden Komma und Punkt erst als Character/ Text (innere Klammer) 
# und dann als Numerische Variable festgesetzt "sub" == substituieren, um echte Numerische Einträge zu bekommen.

summary(feldfr) #Somit kann geprüft werden, ob Zahlenwerte vorliegen (ansonsten würde ein Fehler beim Rechnen angezeigt werden)

source(paste0(da_scripts, "func_splitplace.R")) # funktion reinladen

feldfr_clean <- split_place(df=feldfr) # funktion anwenden

head(feldfr_clean)

saveRDS(feldfr_clean, paste0(da_data, "fruechte_clean.rds")) # neuen table als rds_file speichern

