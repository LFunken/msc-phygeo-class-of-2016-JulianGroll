# Collatz Problem

last<- NULL
l<-1
for (n in seq(10, 50, 1)){
  cr <- NULL
  i<- 0
  while (n > 1){
    if ((n %% 2) == 0) {
      n<- n/2
    } else {
      n<- 3 * n +1
    }
    i<- i + 1
    cr[i]<- n
  }
  l<- l + 1
  last[[l]] <- cr[(length(cr)-2) : length(cr)]
}
