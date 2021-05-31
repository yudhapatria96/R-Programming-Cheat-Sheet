  library(ggplot2)
  
  #membaca data csv
  data.kelahiran <- read.csv("https://data.go.id/dataset/data-kelahiran-bayi-berdasarkan-kategori-urutan-anak-dilahirkan-per-kelurahan/5783ffe7-3a48-4dbd-aa37-aa19a20ec776/download", sep=",")
  
  names(data.kelahiran)
  
  plot.kelahiran <- ggplot(data=data.kelahiran, aes(x= nama_kota, y= jumlah, fill= urutan_anak))
  
  plot.kelahiran + geom_bar(stat="identity", position="dodge")
