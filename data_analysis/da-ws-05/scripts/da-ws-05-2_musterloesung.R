library(car)
library(lmtest)

da_base <- "D:/Dokumente/Studium/Master_Marburg/data/data_analysis/"
da_data_csv <- paste0(da_base, "csv/")


harvest <- readRDS(paste0(da_data_csv, "fruechte_clean.Rds"))
head(harvest)

# only get rows with no NA in Winter_wheat or Winter_barley
harvest <- harvest[!is.na(harvest$Winter_wheat),]
harvest <- harvest[!is.na(harvest$Winterbarley),]
summary(harvest)

# linear model
attach(harvest)
model <- lm(Winterbarley ~ Winter_wheat)
plot(Winter_wheat, Winterbarley)
regLine(model, col = "red")





# Normal distribution of residuals
# Das Histogramm zeigt eine Normalverteilung der Residuen.
hist(model$residuals, nclass = 100)
# Heteroscedacity
# Die recht gleichm��ige Verteilung der Residuen um die Horizontale l�sst auf eine gleichm��ige Verteilung der Varianz schlie�en.
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
  random_sample <- harvest[sample(seq(1:nrow(harvest)), 50, replace = FALSE),]
  random_lm <- lm(random_sample$Winterbarley ~ random_sample$Winter_wheat)
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
  random_sample <- harvest[sample(seq(1:nrow(harvest)), 100, replace = FALSE),]
  random_lm <- lm(random_sample$Winterbarley ~ random_sample$Winter_wheat)
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

# Der Shapiro Wilk Test ist auf Probengr��en kleiner 50 ausgelegt.
# Wenn Stichproben aus einer Datenmenge als lineare Modelle verarbeitet werden,
# sollten die Stichprobengr��en zwischen 25 und 40 liegen um diese auf Normalverteilung untersuchen
# zu k�nnen.