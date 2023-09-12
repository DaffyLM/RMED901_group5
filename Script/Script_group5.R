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
OurData

#Variable type changes
##PID, mounth, year and age to integer
##Black, white, Nat.Am, Asian, Hisp to logical
##BMI to integer
##Hypertension, diabetes to logical
##BL.Diab.Type to factor
