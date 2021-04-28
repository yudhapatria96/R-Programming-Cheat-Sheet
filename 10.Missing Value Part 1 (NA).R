x <- 3
y <- NA

is.na(x)
is.na(y)


typeof(NA_integer_)
typeof(NA_real_)
typeof(NA_complex_)
typeof(NA_character_)
is.na(NA_integer_)
is.na(NA_real_)
is.na(NA_complex_)
is.na(NA_character_)

z <- c(1,2,3,NA,5,6,NA)

lapply(z, typeof)

is.na(z)