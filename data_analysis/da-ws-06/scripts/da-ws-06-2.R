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
crop <- crop[, keep]
summary(crop)

range <- nrow(crop)
nbr <- nrow(crop) * 0.8

cv_sample <- lapply(seq(100), function(i){
  set.seed(i)
  smpl <- sample(range, nbr)
  train <- crop[smpl,]
  test <- crop[-smpl,]
  lmod <- lm(Winter_wheat ~ Winterbarley, data = train)
  pred <- predict(lmod, newdata = test)
  obsv <- test$Winter_wheat
  resid <- obsv-pred
  ss_obsrv <- sum((obsv - mean(obsv))**2)
  ss_model <- sum((pred - mean(obsv))**2)
  ss_resid <- sum((obsv - pred)**2)
  mss_obsrv <- ss_obsrv / (length(obsv) - 1)
  mss_model <- ss_model / 1
  mss_resid <- ss_resid / (length(obsv) - 2)
  data.frame(pred = pred,
             obsv = obsv,
             resid = resid,
             ss_obsrv = ss_obsrv,
             ss_model = ss_model,
             ss_resid = ss_resid,
             mss_obsrv = mss_obsrv,
             mss_model = mss_model,
             mss_resid = mss_resid,
             r_squared = ss_model / ss_obsrv
  )
})
cv_sample <- do.call("rbind", cv_sample)

ss_obsrv <- sum((cv_sample$obsv - mean(cv_sample$obsv))**2)
ss_model <- sum((cv_sample$pred - mean(cv_sample$obsv))**2)
ss_resid <- sum((cv_sample$obsv - cv_sample$pred)**2)

mss_obsrv <- ss_obsrv / (length(cv_sample$obsv) - 1)
mss_model <- ss_model / 1
mss_resid <- ss_resid / (length(cv_sample$obsv) - 2)

plot(cv_sample$obsv, (cv_sample$obsv - cv_sample$pred))

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

rmse <- round(sqrt(mean((cv_sample$pred - cv_sample$obs)^2, na.rm = TRUE)), 2)
min_1 <- round(min(cv_sample$pred - cv_sample$obs, na.rm = TRUE), 2)
quan_25 <- round(quantile(cv_sample$pred - cv_sample$obs, c(0.25), type = 1), 2)
quan_50 <- round(quantile(cv_sample$pred - cv_sample$obs, c(0.5), type = 1), 2)
quan_75 <- round(quantile(cv_sample$pred - cv_sample$obs, c(0.75), type = 1), 2)
max_1 <- round(max(cv_sample$pred - cv_sample$obs, na.rm = TRUE), 2)


data.frame(NAME = c("Root mean square error (RMSE)", "Minimum", 
                    "Quantile_25%", "Quantile_50%", 
                    "Quantile_75%", "Maximum"),
           VALUE = c(rmse, min_1,
                     quan_25, quan_50,
                     quan_75, max_1))

