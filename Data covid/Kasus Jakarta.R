library(httr)
library(ggplot2)
library(hrbrthemes)
library(dplyr)
library(tidyr)

resp_jakarta <- GET("https://data.covid19.go.id/public/api/prov_detail_DKI_JAKARTA.json")
cov_jakarta_raw <- content(resp_jakarta, as = "parsed", simplifyVector = TRUE)

names(cov_jakarta_raw)

cov_jakarta_raw$kasus_total
cov_jakarta_raw$meninggal_persen
cov_jakarta_raw$sembuh_persen

cov_jakarta <- cov_jakarta_raw$list_perkembangan
str(cov_jakarta)

head(cov_jakarta)


new_cov_jakarta <-
  cov_jakarta %>% 
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
str(new_cov_jakarta)  



cov_jakarta_akumulasi <- 
  new_cov_jakarta %>% 
  transmute(
    tanggal,
    akumulasi_aktif = cumsum(kasus_baru),
    akumulasi_sembuh = cumsum(sembuh),
    akumulasi_meninggal = cumsum(meninggal)
  )

print(cov_jakarta_akumulasi)
dim(cov_jakarta_akumulasi)

cov_jakarta_akumulasi_pivot <- 
  cov_jakarta_akumulasi %>% 
  gather(
    key = "kategori",
    value = "jumlah",
    -tanggal
  ) %>% 
  mutate(
    kategori = sub(pattern = "akumulasi_", replacement = "", kategori)
  )

dim(cov_jakarta_akumulasi_pivot)

ggplot(cov_jakarta_akumulasi_pivot, aes(tanggal, jumlah/1000000, colour=(kategori)))+
  geom_line(size=0.9)+
  scale_y_continuous(sec.axis=dup_axis(name=NULL))+
  scale_colour_manual(
    values=c(
      "aktif"="salmon",
      "meninggal"="darkslategray4",
      "sembuh"="olivedrab2"
    ),
    labels=c("Aktif", "Meninggal", "Sembuh")
  )+
  labs(
    x=NULL,
    y="Jumlah kasus akumulasi(Satuan Juta)",
    colour=NULL,
    title="Dinamika Kasus COVID-19 di DKI JAKARTA",
    caption="Sumber data: covid.19.go.id"
  )+
  theme_ipsum(
    base_size=13,
    plot_title_size=15,
    grid="Y",
    ticks=TRUE
  )+
  theme(
    plot.title=element_text(hjust=0.5),
    legend.position="top"
  )

warnings()