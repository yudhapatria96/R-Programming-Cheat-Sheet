library(ggplot2)

info.zakat.dki <- read.csv("https://data.go.id/dataset/data-realisasi-zakat-infaq-shodaqoh-kota-administrasi-jakarta-barat/7c9d401c-07ae-45c3-b893-5f7094fe75db/download", sep=",")
names(info.zakat.dki)


plot.zakat <- ggplot(data=info.zakat.dki, aes(x = kecamatan, y = setoran/1000, color = provinsi))

#menambahkan layer
plot.zakat <- plot.zakat + layer(geom = "point", stat="identity", position = "identity")

plot.zakat