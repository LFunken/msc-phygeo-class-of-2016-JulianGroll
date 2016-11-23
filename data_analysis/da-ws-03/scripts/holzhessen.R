# Holzeinschlag Hessen Tabelle

#Aufgabe 1

Holzhessen <- read.table("D:/Dokumente/Studium/Master_Marburg/Semester_1/Data_Analysis/da-ws-03-1/hessen_holzeinschlag_1997-2014.csv", skip = 4, header = TRUE, sep = ";", dec = ",",nrows = 18)

Holzhessen

boxplot(Holzhessen[2:7])

# Aufgabe 2

# Buche: Im betrachteten Zeitraum wurden zwischen 1000 und 2000 Einheiten jährlich geschlagen, wobei die häufigste Menge zwischen 1500 und 1900 Einheiten lag.
  
# Fichte: Im betrachteten Zeitraum wurden zwischen 1000 und 6500 Einheiten jährlich geschlagen, wobei die häufigsten Mengen zwischen 1700 und 3000 Einheiten liegen und die 6500 ein im Betrachtungszeitraum einmaliges Ereignis darstellen.

par(mfrow = c(2,2))
plot(Holzhessen$Eiche, Holzhessen$Buche)
plot(Holzhessen$Kiefer, Holzhessen$Buche)
plot(Holzhessen$Fichte, Holzhessen$Buche)
plot(Holzhessen$Buntholz, Holzhessen$Buche)



