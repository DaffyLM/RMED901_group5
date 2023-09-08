library(tidyverse)
install.packages("here")
library(here)
here()

df <- read_csv2(here("DATA", "Konsultasjoner.csv"))#read_csv2 leser semikolonnedelte csv-filer
df
glimpse(df)
head(df)
tail(df)
view(df)

install.packages("skimr")
skimr::skim(df)

install.packages("naniar")
naniar::gg_miss_var(df) #identifiserer manglende data
