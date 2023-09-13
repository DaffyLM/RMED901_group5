
library(tidyverse)
library(here)
here()

read_tsv(here("Data", "exam_data.txt"))
OurData <- read_tsv(here("Data", "exam_data.txt"))
OurData
summary(OurData)
glimpse(OurData)
View(OurData)        
skimr::skim(OurData) 


OurData <- OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`) %>%
  naniar::gg_miss_var() %>%
  separate(col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"), sep = "_") %>%
  distinct()
