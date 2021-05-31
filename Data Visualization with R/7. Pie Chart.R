library(ggplot2)

#membaca data csv

data.kelahiran <- read.csv("https://data.go.id/dataset/data-kelahiran-bayi-berdasarkan-kategori-urutan-anak-dilahirkan-per-kelurahan/5783ffe7-3a48-4dbd-aa37-aa19a20ec776/download", sep=",")

z <- aggregate(x=list(JUMLAH = data.kelahiran$jumlah), FUN = sum, by = list(nama.kota = data.kelahiran$nama_kota))


plot.kelahiran <- ggplot(data = z, aes(x="", y=JUMLAH, fill = nama.kota))
plot.kelahiran <- plot.kelahiran + geom_bar(width = 1, stat = "identity")
plot.kelahiran <- plot.kelahiran + coord_polar("y", start=0)
plot.kelahiran
