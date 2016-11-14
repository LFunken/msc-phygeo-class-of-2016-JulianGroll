da_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Data_Analysis/"
da_data <- paste0(da_base, "da-ws-04-1/")
da_scripts <- paste0(da_base, "scripts/")

flaeche <- read.table(paste0(da_data, "AI001_gebiet_flaeche.txt"), skip = 5, header = FALSE, sep = ";", dec = ",", fill = TRUE, encoding = "ANSI") #"fill"-Funktion und "encoding" nicht vergessen

head(flaeche)

str(flaeche)

tail(flaeche)

names(flaeche) <- c("Year", "ID", "Place", "Settlement", "Recreation", "Agriculture", "Forest")


tail(flaeche)

for(c in colnames(flaeche)[4:7]){
  flaeche[, c][flaeche[, c] == "." |
                 flaeche[, c] == "-" |
                 flaeche[, c] == "," |
                 flaeche[, c] == "/"] <- NA
  flaeche[, c] <- as.numeric(sub(",", ".", as.character(flaeche[, c])))
}  

summary(flaeche) 

source(paste0(da_scripts, "func_splitplace.R"))

flaeche_clean <- split_place(df=flaeche)

head(flaeche_clean)

saveRDS(flaeche_clean, paste0(da_data, "flaeche_clean.rds"))

