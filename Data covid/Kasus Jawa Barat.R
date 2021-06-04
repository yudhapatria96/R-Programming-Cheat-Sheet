library(httr)
library(ggplot2)
library(hrbrthemes)
library(dplyr)
library(lubridate)
library(tidyr)


resp_jabar <- GET("https://data.covid19.go.id/public/api/prov_detail_JAWA_BARAT.json")
cov_jabar_raw <- content(resp_jabar, as = "parsed", simplifyVector = TRUE)
names(cov_jabar_raw)
cov_jabar_raw$kasus_total
cov_jabar_raw$meninggal_persen
cov_jabar_raw$sembuh_persen

cov_jabar <- cov_jabar_raw$list_perkembangan
str(cov_jabar)
head(cov_jabar)

new_cov_jabar <-
  cov_jabar %>%
  select(-contains("DIRAWAT_OR_ISOLASI")) %>%
  select(-starts_with("AKUMULASI")) %>%
  rename(
    kasus_baru = KASUS,
    meninggal = MENINGGAL,
    sembuh = SEMBUH
  ) %>%
  mutate(
    tanggal = as.POSIXct(tanggal / 1000, origin = "1970-01-01"),
    tanggal = as.Date(tanggal)
  )
str(new_cov_jabar)

# Visualisasi Kasus Harian Positif corona ========================================


# ggplot(new_cov_jabar, aes(tanggal, kasus_baru)) +
#   geom_col(fill = "salmon") +
#   labs(
#     x = NULL,
#     y = "Jumlah kasus",
#     title = "Kasus Harian Positif COVID-19 di Jawa Barat",
#     subtitle = "Terjadi pelonjakan kasus di awal bulan Juli akibat klaster Secapa AD Bandung",
#     caption = "Sumber data: covid.19.go.id"
#   ) +
#   theme_ipsum(
#     base_size = 13,
#     plot_title_size = 21,
#     grid = "Y",
#     ticks = TRUE
#   ) +
#   theme(plot.title.position = "plot")

# Visualisasi Kasus Harian positif corona ========================================

# Visualisasi Kasus Harian Sembuh ========================================


# ggplot(new_cov_jabar, aes(tanggal, sembuh)) +
#   geom_col(fill = "olivedrab2") +
#   labs(
#     x = NULL,
#     y = "Jumlah kasus",
#     title = "Kasus Harian Sembuh Dari COVID-19 di Jawa Barat",
#     caption = "Sumber data: covid.19.go.id"
#   ) +
#   theme_ipsum(
#     base_size = 13,
#     plot_title_size = 21,
#     grid = "Y",
#     ticks = TRUE
#   ) +
#   theme(plot.title.position = "plot")

# Visualisasi Kasus Harian Sembuh ========================================


#Visualisasi Kasus Kematian Harian ========================================


# ggplot(new_cov_jabar, aes(tanggal, meninggal)) +
#   geom_col(fill = "darkslategray4") +
#   labs(
#     x = NULL,
#     y = "Jumlah kasus",
#     title = "Kasus Harian Meninggal Akibat COVID-19 di Jawa Barat",
#     caption = "Sumber data: covid.19.go.id"
#   ) +
#   theme_ipsum(
#     base_size = 13,
#     plot_title_size = 21,
#     grid = "Y",
#     ticks = TRUE
#   ) +
#   theme(plot.title.position = "plot")

#Visualisasi Kasus Kematian Harian ========================================



# Data Pekanan ======================================

cov_jabar_pekanan <- new_cov_jabar %>%
  count(
    tahun = year(tanggal),
    pekan_ke = week(tanggal),
    wt = kasus_baru,
    name = "jumlah"
  )

glimpse(cov_jabar_pekanan)

# Data Pekanan ======================================


# Proses untuk mengetahui apakah kasus corona pada pekan lalu lebih baik(?)=================

library(dplyr)
cov_jabar_pekanan <-
  cov_jabar_pekanan %>%
  mutate(
    jumlah_pekanlalu = dplyr::lag(jumlah, 1),
    jumlah_pekanlalu = ifelse(is.na(jumlah_pekanlalu), 0, jumlah_pekanlalu),
    lebih_baik = jumlah < jumlah_pekanlalu
  )
glimpse(cov_jabar_pekanan)


# Proses untuk mengetahui apakah kasus corona pada pekan lalu lebih baik(?)=================


# visualisasi data perbandingan kasus corona ========================================


ggplot(cov_jabar_pekanan, aes(pekan_ke, jumlah, fill = lebih_baik)) +
  geom_col(show.legend = FALSE) +
  scale_x_continuous(breaks = 1:55, expand = c(0, 0)) +
  scale_fill_manual(values = c("TRUE" = "seagreen3", "FALSE" = "salmon")) +
  labs(
    x = NULL,
    y = "Jumlah kasus",
    title = "Kasus Pekanan Positif COVID-19 di Jawa Barat",
    subtitle = "Kolom hijau menunjukan penambahan kasus baru lebih sedikit dibandingkan satu pekan sebelumnya",
    caption = "Sumber data: covid.19.go.id"
  ) +
  theme_ipsum(
    base_size = 6,
    plot_title_size = 21,
    grid = "Y",
    ticks = TRUE
  ) +
  theme(plot.title.position = "plot")

# visualisasi data perbandingan kasus corona ========================================


# Proses melakukan akumulasi kasus bulanan =================
cov_jabar_akumulasi <-
  new_cov_jabar %>%
  transmute(
    tanggal,
    akumulasi_aktif = cumsum(kasus_baru) - cumsum(sembuh) - cumsum(meninggal),
    akumulasi_sembuh = cumsum(sembuh),
    akumulasi_meninggal = cumsum(meninggal)
  )

tail(cov_jabar_akumulasi)



dim(cov_jabar_akumulasi)


cov_jabar_akumulasi_pivot <-
  cov_jabar_akumulasi %>%
  gather(
    key = "kategori",
    value = "jumlah",
    -tanggal
  ) %>%
  mutate(
    kategori = sub(pattern = "akumulasi_", replacement = "", kategori)
  )

dim(cov_jabar_akumulasi_pivot)


glimpse(cov_jabar_akumulasi_pivot)

# Proses melakukan akumulasi kasus bulanan =================

# Visualisasi kasus bulanan ======================================================

# ggplot(cov_jabar_akumulasi_pivot, aes(tanggal, jumlah, colour = (kategori))) +
#   geom_line(size = 0.9) +
#   scale_y_continuous(sec.axis = dup_axis(name = NULL)) +
#   scale_colour_manual(
#     values = c(
#       "aktif" = "salmon",
#       "meninggal" = "darkslategray4",
#       "sembuh" = "olivedrab2"
#     ),
#     labels = c("Aktif", "Meninggal", "Sembuh")
#   ) +
#   labs(
#     x = NULL,
#     y = "Jumlah kasus akumulasi",
#     colour = NULL,
#     title = "Dinamika Kasus COVID-19 di Jawa Barat",
#     caption = "Sumber data: covid.19.go.id"
#   ) +
#   theme_ipsum(
#     base_size = 13,
#     plot_title_size = 21,
#     grid = "Y",
#     ticks = TRUE
#   ) +
#   theme(
#     plot.title = element_text(hjust = 0.5),
#     legend.position = "top"
#   )


# Visualisasi kasus bulanan ======================================================
