library(ggplot2)

#membaca data csv
warga.dki <- read.csv("https://data.jakarta.go.id/dataset/b3927bd4-f21f-4253-9858-5fa4f677d213/resource/9c9f741b46a2226185a43fd17bff5c6c/download/Data-Jumlah-Kepadatan-Penduduk-Per-Kelurahan-Tahun-2020.csv", sep=",")

names(warga.dki)

plot.warga.dki <- ggplot(data = warga.dki, aes(x = jumlah_kepadatan_.jiwa.km2., fill= nama_kecamatan))
plot.warga.dki + geom_histogram(binwidth=15000)