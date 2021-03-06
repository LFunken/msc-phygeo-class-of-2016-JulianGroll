# Holzeinschlag Hessen Tabelle

#Aufgabe 1

Holzhessen <- read.table("D:/Dokumente/Studium/Master_Marburg/Semester_1/Data_Analysis/da-ws-03-1/hessen_holzeinschlag_1997-2014.csv", skip = 4, header = TRUE, sep = ";", dec = ",",nrows = 18)

Holzhessen

boxplot(Holzhessen[2:7])

# Aufgabe 2

# Buche: Im betrachteten Zeitraum wurden zwischen 1000 und 2000 Einheiten j�hrlich geschlagen, wobei die h�ufigste Menge zwischen 1500 und 1900 Einheiten lag.
  
# Fichte: Im betrachteten Zeitraum wurden zwischen 1000 und 6500 Einheiten j�hrlich geschlagen, wobei die h�ufigsten Mengen zwischen 1700 und 3000 Einheiten liegen und die 6500 ein im Betrachtungszeitraum einmaliges Ereignis darstellen.

par(mfrow = c(2,2))
plot(Holzhessen$Eiche, Holzhessen$Buche)
# Zu den Zeitpunkten, an denen mittelm��ig viele oder viele Eichen geschlagen wurden, wurden viele Buchen geschlagen.
plot(Holzhessen$Kiefer, Holzhessen$Buche)
# Zu den Zeitpunkten, an denen viele Kiefern geschlagen wurden, wurden auch viele Buchen geschlagen.
plot(Holzhessen$Fichte, Holzhessen$Buche)
# Zu einigen Zeitpunkten wurden �hnlich viele Fichten geschlagen wie Buchen, in manchen Jahren deutlich mehr, einmal weniger.
plot(Holzhessen$Buntholz, Holzhessen$Buche)
# Buntholz wurde nur zu drei Zeitpunkten separat geschlagen, und das stets in deutlich geringerem Ausma� als Buchen geshlagen wurden.




