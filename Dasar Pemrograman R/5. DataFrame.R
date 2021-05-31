#Data Frame

#contoh membuat data frame dari vektor
pemrograman <- c("Bahasa Pemrograman", "Tujuan")
isi_data <-c("R", "Data Science")

pemrograman <- data.frame(pemrograman, isi_data)
pemrograman



#menampilkan kolom isi_data
pemrograman$isi_data