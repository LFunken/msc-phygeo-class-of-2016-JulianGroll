# Sessioninfo

R version 3.3.1 (2016-06-21)
Platform: x86_64-w64-mingw32/x64 (64-bit)
Running under: Windows >= 8 x64 (build 9200)

locale:
  [1] LC_COLLATE=German_Germany.1252  LC_CTYPE=German_Germany.1252   
[3] LC_MONETARY=German_Germany.1252 LC_NUMERIC=C                   
[5] LC_TIME=German_Germany.1252    

attached base packages:
  [1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
  [1] tools_3.3.1




a <- 1

#Aufgabe 1

if (a > 1) {
  print("Larger")
} else {
  print("Equal or smaller")
}

# Aufgabe 2

if (a > 1) {
  print("Larger")
} else if (a < 1) {
  print("smaller")
} else if (a == 1) {
  print("Equal")
}

# Aufgabe 3

if ((a %% 2) == 0) {
  print("even")
} else {
  print("odd")
}

#Aufgabe 4

# Variablen v1,v2,v3 für die Aufgaben 1-3 vergeben

v1 <- if (a > 1) {
  print("Larger")
} else {
  print("Equal or smaller")
}

v2 <- if (a > 1) {
  print("Larger")
} else if (a < 1) {
  print("smaller")
} else if (a == 1) {
  print("Equal")
}

v3 <- if ((a %% 2) == 0) {
  print("even")
} else {
  print("odd")
}

# h1 als Vektor der Variablen v1,v2,v3

h1 <- c(v1,v2,v3)

# For loop der Aufgabe 4

for (a in h1) {
  print(h1)
}

# Aufgabe 5 (Ergebnis als Vektor ausgeben)

vek <-c()
for (a in h1) vek <- c(vek,h1)

vek

# Aufgabe 6 (Ergebnis als Liste ausgeben)

L1 <- list()
for (a in h1) L1 <- list(h1)
L1

# Aufgabe 7

L2 <- list(a)
func <- function(h1)
  lapply(L2, h1)

