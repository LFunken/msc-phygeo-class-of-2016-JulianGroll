library(car)
library(lmtest)

da_base <- "D:/Dokumente/Studium/Master_Marburg/data/data_analysis/"
da_data_csv <- paste0(da_base, "csv/")


crop <- readRDS(paste0(da_data_csv, "fruechte_clean.Rds"))

head(crop)
 
ind <- crop$Winter_wheat

dep <- crop$Winterbarley

plot(dep, ind)

lmod <- lm(dep ~ ind)
nrow(crop)
head(crop)
crop <- crop[!is.na(crop$Winter_wheat), ]
crop <- crop[!is.na(crop$Winterbarley), ]
keep <- c("Winter_wheat", "Winterbarley")
area <- crop[, keep]
summary(crop)

cv <- lapply(seq(nrow(crop)), function(i){
  train <- crop[-i, ]
  test <- crop[i, ]
  lmod <- lm(Winter_wheat ~ Winterbarley, data=train)
  pred <- predict(lmod , newdata = test)
  obsv <- test$Winter_wheat
  data.frame(pred = pred,
             obsv = obsv,
             model_r_squared = summary(lmod)$r.squared)
})
cv <- do.call("rbind", cv)
summary(cv)
cv

ss_obsrv <- sum((cv$obsv - mean(cv$obsv))**2)
ss_model <- sum((cv$pred - mean(cv$obsv))**2)
ss_resid <- sum((cv$obsv - cv$pred)**2)

mss_obsrv <- ss_obsrv / (length(cv$obsv) - 1)
mss_model <- ss_model / 1
mss_resid <- ss_resid / (length(cv$obsv) - 2)

plot(cv$obsv, (cv$obsv - cv$pred))

data.frame(NAME = c("cross-validation F value",
                    "linear model F value", 
                    "cross-validatino r squared",
                    "lienar model r squared"),
           VALUE = c(round(mss_model / mss_resid, 2),
                     round(anova(lmod)$'F value'[1], 2),
                     round(1 - ss_resid / ss_obsrv, 2),
                     round(summary(lmod)$r.squared, 2)))

summary(cv$model_r_squared)

se <- function(x) sd(x, na.rm = TRUE)/sqrt(length(na.exclude(x)))

me <- round(mean(cv$pred - cv$obs, na.rm = TRUE), 2)
me_sd <- round(se(cv$pred - cv$obs), 2)
mae <- round(mean(abs(cv$pred - cv$obs), na.rm = TRUE), 2)
mae_sd <- round(se(abs(cv$pred - cv$obs)), 2)
rmse <- round(sqrt(mean((cv$pred - cv$obs)^2, na.rm = TRUE)), 2)
rmse_sd <- round(se((cv$pred - cv$obs)^2), 2)

data.frame(NAME = c("Mean error (ME)", "Std. error of ME", 
                    "Mean absolute error (MAE)", "Std. error of MAE", 
                    "Root mean square error (RMSE)", "Std. error of RMSE"),
           VALUE = c(me, me_sd,
                     mae, mae_sd,
                     rmse, rmse_sd))