#Grafik Chart dengan Manual Data / data dummy alias fiksi

install.packages("ggplot2")
install.packages("openxlsx")
library(ggplot2)
library(openxlsx)

info_corona <- read.xlsx("https://drive.google.com/u/6/uc?id=1WQ3Kv3XH_U1fun560JFKaiibv1oy9qm6&export=download")
info_corona

#membuat canvas 
base_canvas <- ggplot(info_corona, aes(x=Kota, y=Jumlah_Kasus, fill=Kota))
base_canvas <- base_canvas + geom_bar(width=1, stat="identity")
base_canvas
#tambah judul grafik
base_canvas<- base_canvas + ggtile("Jumlah Kasus Corona per kota")

#tambah keterangan pada sumbu x
base_canvas <- base_canvas + xlab("Nama Kota")

#tambah keterangan pada sumbu y
base_canvas <- base_canvas + ylab("Jumlah Kasus Corona")

base_canvas
