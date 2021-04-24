#Grafik Chart dengan Manual Data / data dummy alias fiksi

install.packages("ggplot2")
library(ggplot2)

kota <- c("Jakarta", "Depok", "Tangerang")
jumlah_kasus <- c(1000,700,600)

info_corona <- data.frame(kota, jumlah_kasus)
info_corona

#membuat canvas 
  base_canvas <- ggplot(info_corona, aes(x=kota, y=jumlah_kasus, fill=kota))
  base_canvas <- base_canvas + geom_bar(width=1, stat="identity")
  base_canvas
#tambah judul grafik
  base_canvas<- base_canvas + ggtile("Jumlah Kasus Corona per kota")

#tambah keterangan pada sumbu x
  base_canvas <- base_canvas + xlab("Nama Kota")

#tambah keterangan pada sumbu y
  base_canvas <- base_canvas + ylab("Jumlah Kasus Corona")
  
  base_canvas
