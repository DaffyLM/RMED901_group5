library(tidyverse)
install.packages("here")
library(here)
here()

OurData <- read_tsv(here("DATA", "exam_data.txt"))
OurData
glimpse(OurData)
head(OurData)
tail(OurData)
view(OurData)

#Remove duplicates
OurData <- OurData %>%
  distinct()

#Endret fra 835 til 834 rader