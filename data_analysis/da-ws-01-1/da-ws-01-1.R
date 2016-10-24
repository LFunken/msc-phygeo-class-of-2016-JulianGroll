
#creating variables a and b
a <- 2
b <- 5

# processing of a and b to create sum, difference, product and ratio in variables r1 - r4
r1 <- a+b
r2 <- a-b
r3 <- a*b
r4 <- a/b

# creating a vector v1 that contains the processed values
v1 <- c(r1,r2,r3,r4)

#adding a fifth value to v1
v1 <- c(v1,a**b)

#show the result of v1
v1

#create v2 containing 
v2 <- c("sum","difference","product","ratio","a^b")

#show the result of v2
v2

#creating dataframe df containing v1 and v2 as columns
df <- cbind(v1,v2)

#giving names to the columns of df
colnames(df) <- c("results","operation")

#show the result of df
df

# show the df-entry row 3 column 1
df[3,1]