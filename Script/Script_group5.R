library(tidyverse)
library(here)
here()
read_tsv(here("Data","exam_data.txt"))
OurData <- read_tsv(here("Data", "exam_data.txt"))
head(OurData)
view(OurData)
glimpse(OurData)

OurData <-
  OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`)

glimpse(OurData)
