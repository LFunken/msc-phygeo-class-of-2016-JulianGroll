
a<-5
b<-10

#2.)1.)
if(a>1){
  print("larger")
} else {
  print("equal or smaller")
}

#2.).2)
if (a>1){
  print("Larger")
} else if (a==1) {
  print("equal")
} else if (a<1) {
  print("smaller")
}

#2.)3.)
if((a%%2)==0) {
  print("Even")
} else {
  print("odd")
}


if((b%%2)==0) {
  print("Even")
} else {
  print("Odd")
}

#2.)4.)
for(i in 0:2)
  if (i>1){
    print("larger")
  } else if (i==1){
    print("equal")
  } else {
    print ("smaller")
  }

#2.)5.)

r1<-c()
  for(i in 0:2)
  if (i>1){
    r1<-c(r1,"larger")
  } else if (i==1){
    r1<-c(r1,"equal")
  } else {
    r1<-c(r1,"smaller")
  }


#2.)6.)

l1<-list()
for(i in 0:2)
  if (i>1){
    l1<-c(l1,"larger")
  } else if (i==1){
    l1<-c(l1,"equal")
  } else {
    l1<-c(l1,"smaller")
  }

l1

#2.)7.)

ltst <- list(0,1,2)
tst <- list()
eqtst <- function(i)
  if (i>1){
  tst<-c(tst,"larger")
} else if (i==1){
  tst<-c(tst,"equal")
} else {
  tst<-c(tst,"smaller")
}

tst<-lapply(ltst,eqtst)

tst

#2.)8.)

tst_2<-do.call(c,tst)

tst_2
