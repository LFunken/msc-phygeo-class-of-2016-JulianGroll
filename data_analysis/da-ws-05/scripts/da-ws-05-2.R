library(car)
library(lmtest)

da_base <- "D:/Dokumente/Studium/Master_Marburg/data/data_analysis/"
da_data_csv <- paste0(da_base, "csv/")


feldfr <- readRDS(paste0(da_data_csv, "fruechte_clean.Rds"))

head(feldfr)

ind <- feldfr$Winter_wheat

dep <- feldfr$Winterbarley

plot(dep, ind)

lmod <- lm(dep ~ ind)

regLine(lmod, col = "blue")

par(mfrow = c(2,2))
plot(lmod)

# Wie im Bild "Residuals vs Fittet" zu sehen, sind die Daten homoscedastisch verteilt
# und in Bild Normal Q-Q ist zu erkennen, dass die Werte bis auf wenige Ausreiser normal verteilt sind.



# 50 samples
lmod_2 <- c()
test <- c()

repeat {
  test <- feldfr[sample(nrow(feldfr), 50), ]
  
  ind_1 <- test$Winter_wheat
  dep_1 <- test$Winterbarley
  
  lmod_1 <- ks.test(ind_1, dep_1)
  
  if (lmod_1$p.value < 0.05) {
    lmod_2 <- c(lmod_2, "hyp_rej")
  } else {
    lmod_2 <- c(lmod_2, "hyp_acp")
  }
  if (length(lmod_2) == 100) {  ## Endlosschleife stoppen
    break
  }
}
res50 <- table(lmod_2)
res50

# 100 Samples

lmod_4 <- c()
test_1 <- c()

repeat {
  test_1 <- feldfr[sample(nrow(feldfr), 100), ]
  
  ind_1a <- test_1$Winter_wheat
  dep_1a <- test_1$Winterbarley
  
  lmod_3 <- ks.test(ind_1a, dep_1a)
  
  if (lmod_3$p.value < 0.05) {
    lmod_4 <- c(lmod_4, "hyp_rej")
  } else {
    lmod_4 <- c(lmod_4, "hyp_acp")
  }
  if (length(lmod_4) == 100) {  ## Endlosschleife stoppen
    break
  }
}
res100 <- table(lmod_4)
res50
res100

# Bei 50 gezogenen Samples wird die Nullhypothese in ca. 10% der Fälle akzeptiert wohingegen sie bei
# 100 Samples, in diesem Durchlauf, nicht ein einziges mal akzeptiert wurde.
# Die erweckt den Eindruck, dass eine höhere Anzahl von Samples den Test unempfindlicher gegenüber Ausreissern macht.