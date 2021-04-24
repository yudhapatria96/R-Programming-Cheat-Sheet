library(ggplot2)
library(openxlsx)

#membaca file
info_corona <- read.xlsx("https://drive.google.com/u/6/uc?id=1VVPx1jbl--BFJrWbw8Da_5OOx_YpCnFw&export=download", sheet="Sheet1")
info_corona

#menghitung jumlah data by provinsi
sumbyprov<- aggregate(x= info_corona$Jumlah_Kasus,
                      by=list(Kategori=info_corona$Provinsi), FUN= sum)
sumbyprov<- setNames(sumbyprov, c("provinsi", "jumlah_kasus"))
sumbyprov

#membuat piechart
piechart <- ggplot(sumbyprov, aes(x="", y = jumlah_kasus, fill= provinsi)) +
  geom_bar(width=1, stat="identity")
piechart <- piechart + coord_polar("y", start = 0)
piechart <- piechart + ggtile("Distribusi kasus corona by provinsi")
piechart <- piechart + scale_fill_brewer(palette="Red")+ theme_minimal()
piechart <- piechart + guides(fill=guide_legend(title="Provinsi"))
piechart <- piechart + ylab("Jumlah Kasus Corona")
piechart