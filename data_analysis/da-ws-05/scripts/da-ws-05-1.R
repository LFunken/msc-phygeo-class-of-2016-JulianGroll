library(car)
library(lmtest)

da_base <- "D:/Dokumente/Studium/Master_Marburg/Semester_1/Data_Analysis/"
da_data <- paste0(da_base, "da-ws-04-1/")
da_scripts <- paste0(da_base, "scripts/")

feldfr <- readRDS(paste0(da_data, "fruechte_clean.Rds"))

head(feldfr)

ind <- feldfr$Winter_wheat

dep <- feldfr$Winterbarley

plot(dep, ind)

lmod <- lm(dep ~ ind)

abline(lmod, col = "green")

regLine(lmod, col = "blue")

plot(lmod)
#################################################################################

p_value <-c()

for (i in 1:100) {
  test <- feldfr[i][sample(nrow(feldfr), 50, replace = TRUE), ]
  
  ind_1 <- test$Winter_wheat
  dep_1 <- test$Winterbarley
  
  ks_test <- ks.test(ind_1, dep_1)
  
  p_value <- ks_test$p.value
  p_value
}

###########
a <- list()

for (i in 1:5) {
  a <- i+5
}

a


#############

test <- feldfr[sample(nrow(feldfr), 50, replace = TRUE), ]
test
ind_1 <- test$Winter_wheat
dep_1 <- test$Winterbarley
ind_1
dep_1
plot(ind_1, dep_1)

ks_test <- ks.test(ind_1, dep_1)

p_value <- ks_test$p.value

p_value()

##################################################################################

if (lmod_1$p.value < 0.05) {
  lmod_2 <- c(lmod_2, "hyp_rej")
} else {
  lmod_3 <- c(lmod_3, "hyp_acp")
}
lmod_2$p.value
#######################################################


lmod_2 <- c()
lmod_3 <- c()

test <- c()

for (i in 1:100) {
  test[i] <- feldfr[sample(nrow(feldfr), 50), ]
  
  ind_1 <- test$Winter_wheat
  dep_1 <- test$Winterbarley
  
  lmod_1 <- ks.test(ind_1, dep_1)
  if (lmod_1$p.value < 0.05) {
    lmod_2 <- c(lmod_2, "hyp_rej")
  } else {
    lmod_3 <- c(lmod_3, "hyp_acp")
  }
}



#############################################################
for (i in 1:100) {
  test(i) if (lmod_2$p.value < 0.05) {
    lmod_3 <- c(lmod_3, "hyp1_rej")
  } else {
    lmod_4 <- c(lmod_4, "hyp_acp")
  }
}

length(lmod_3)
length(lmod_4)



ks.tes









if (lmod_2$p.value < 0.01) {
  lmod_3 <- c(lmod_3, "hyp_rej")
} else {
  lmod_4 <- c(lmod_4, "hyp_acp")
}













abline(lmod_1, col = "red")








test <- replicate(2,feldfr[sample(nrow(feldfr), 5, replace = TRUE), ], simplify = FALSE)
test


ind_1 <- test$Winter_wheat
dep_1 <- test$Winterbarley

ind_1

