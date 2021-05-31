library(ggplot2)

saham.indofood.cbp <- read.csv("https://drive.google.com/uc?id=1o2rlmGc0lflVDEpQ-KtEl503-Z1rSiww&export=download", sep=",")

names(saham.indofood.cbp)

plot.saham <- ggplot(data = saham.indofood.cbp, aes(x = Tanggal, y = Harga, color = Kondisi, group = Kondisi))

plot.saham + geom_line() + geom_text(aes(label = Harga), hjust= -0.3, vjust = -0.6)