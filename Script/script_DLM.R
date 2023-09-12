library(tidyverse)
install.packages("here")
library(here)
here()

df <- read_tsv(here("DATA", "exam_data.txt"))
df
glimpse(df)
head(df)
tail(df)
view(df)

df <- df %>%
  distinct()

