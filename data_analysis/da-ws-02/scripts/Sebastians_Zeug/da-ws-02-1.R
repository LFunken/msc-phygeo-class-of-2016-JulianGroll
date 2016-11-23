# Aufgabe 1 und 2

a <- 5

if (a > 1) {print("Larger")} else if(a==1) {print("Equal")} else if(a < 1) {print("Smaller")}

# Aufgabe 3

if((a %% 2) ==0) {print("Even")} else {print("Odd")}

# Aufgabe 4

a1 <- if (a > 1) {print("Larger")} else if(a==1) {print("Equal")} else if(a < 1) {print("Smaller")}

a2 <- if((a %% 2) ==0) {print("Even")} else {print("Odd")}

V1 <- c(a1, a2)

for (a in V1) {print(V1)}

# Aufgabe 5

E5 <-c()

for (a in V1) E5 <- c(E5, V1)

# Aufgabe 6

E6 <- list()

for (a in V1) E6 <- list(V1)

E6

#Aufgabe 7

L7 <- list(V1)

L7

fct <- function(a)
  if (a > 1){
    L7 <- c(L7,"Larger")
  } else if (a==1){
    L7 <- c(L7,"Equal")
  } else if (a < 1){
    L7 <- c(L7,"Smaller")
  }

Loopung <- lapply(L7, fct)

Loopung

# Aufgabe 8

A8 <- do.call(c, unlist(Loopung, recursive=FALSE))

A8

