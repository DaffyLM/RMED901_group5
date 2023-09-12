library(tidyverse)
library(here)
read_tsv(here("Data", "exam_data.txt"))
# Read the file

OurData <- read_tsv(here("Data", "exam_data.txt"))

OurData %>% 
  glimpse()
# Local_Topical.Anest is also combined, with information on both Local and Topical Anesthetic 

OurData <- OurData %>%
  separate (col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"),
            sep = "_")
# Changed column Local_Topical.Anest with combined variables to two different variables. 

OurData %>% 
  glimpse()
