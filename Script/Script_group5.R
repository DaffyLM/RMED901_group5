
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

#Piped the commands
OurData <- OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`) %>%
  naniar::gg_miss_var() %>%
  separate(col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"), sep = "_") %>%
  distinct()

#Converted coloumn C to either C or T
OurData <- OurData %>%
  mutate(C = case_when(C == "TRUE" ~ "C",
                       TRUE ~ "T"))

#Rename coloumn C to Group
OurData <- OurData %>% 
  rename(Group = C)
View(OurData)
