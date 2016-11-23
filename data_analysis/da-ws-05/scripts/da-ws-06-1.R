library(car)
library(lmtest)

da_base <- "D:/Dokumente/Studium/Master_Marburg/data/data_analysis/"
da_data_csv <- paste0(da_base, "csv/")


flaeche <- readRDS(paste0(da_data_csv, "flaeche_clean.Rds"))

head(flaeche)
summary(flaeche)

flaeche <- flaeche[!is.na(flaeche$Settlement),]
flaeche <- flaeche[!is.na(flaeche$Recreation),]
summary(flaeche)

nrow(flaeche)
lmod <- lm(flaeche$Settlement ~ flaeche$Recreation)

plot(flaeche$Settlement, flaeche$Recreation)

abline(a = lmod$coefficients[1], b = lmod$coefficients[2])



y1 <- flaeche$Settlement
x1 <- flaeche$Recreation

cv <- lapply(seq(nrow(flaeche)), function(i){
  train <- flaeche[-i,]
  test <- flaeche[i,]
  lmod <- lm(y1 ~ x1, data = train)
  pred <- predict(lmod, newdata = test)
  obsv <- test$y1
  data.frame(pred = pred,
             obsv = obsv,
             model_r_squared = summary(lmod)$r.squared)
})
cv <- do.call("rbind", cv)
cv






ss_obsrv <- sum((cv$obsv - mean(cv$obsv))**2)
ss_model <- sum((cv$pred - mean(cv$obsv))**2)
ss_resid <- sum((cv$obsv - cv$pred)**2)

mss_obsrv <- ss_obsrv / (length(cv$obsv) - 1)
mss_model <- ss_model / 1
mss_resid <- ss_resid / (length(cv$obsv) - 2)

plot(cv$obsv, (cv$obsv - cv$pred))























# Normal distribution of residuals
# Das Histogramm zeigt eine Normalverteilung der Residuen.
hist(model$residuals, nclass = 100)
# Heteroscedacity
# Die recht gleichmäßige Verteilung der Residuen um die Horizontale lässt auf eine gleichmäßige Verteilung der Varianz schließen.
plot(model, which = 1)


### Part Two: Random Samples

# decide level of significance
alpha <- 0.05

# testing 100 samples with 50 values on normal distribution with shapiro wilk test
# H0: Values are normally distributed ==> p-value below 0.05 ==> Values are not normally distributed
# set seed for reproducability
# get 50 random rows from dataframe
normal_dist_50 <- lapply(seq(100), function(x){
  set.seed(x)
  random_sample <- flaeche[sample(seq(1:nrow(flaeche)), 50, replace = FALSE),]
  random_lm <- lm(random_sample$Recreation ~ random_sample$Settlement)
  random_shapiro <- shapiro.test(random_lm$residuals)
  
  # reject H0 ?
  if(random_shapiro$p.value < alpha){
    return("reject")
  }else{
    return("no_reject")
  }
})


# testing 100 samples with 100 values on normal distribution with shapiro wilk test
# H0: Values are normally distributed ==> p-value below 0.05 ==> Values are not normally distributed
# set seed for reproducability
# get 100 random rows from dataframe
normal_dist_100 <- lapply(seq(100), function(x){
  set.seed(x)
  random_sample <- flaeche[sample(seq(1:nrow(flaeche)), 100, replace = FALSE),]
  random_lm <- lm(random_sample$Recreation ~ random_sample$Settlement)
  random_shapiro <- shapiro.test(random_lm$residuals)
  
  # reject H0 ?
  if(random_shapiro$p.value < alpha){
    return("reject")
  }else{
    return("no_reject")
  }
})

rejections_50 <- 0
rejections_100 <- 0
for(i in seq(100)){
  if(normal_dist_50[[i]] == "reject"){
    rejections_50 <- rejections_50 + 1
  }
  
  if(normal_dist_100[[i]] == "reject"){
    rejections_100 <- rejections_100 + 1
  }
}
print(rejections_50)
print(rejections_100)

# Der Shapiro Wilk Test ist auf Probengrößen kleiner 50 ausgelegt.
# Wenn Stichproben aus einer Datenmenge als lineare Modelle verarbeitet werden, sollten die Stichprobengrößen zwischen 25 und 40 liegen um diese auf Normalverteilung untersuchen zu können.





















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