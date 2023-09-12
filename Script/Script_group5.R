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

install.packages("here")
library(here)
here()

OurData <- read_tsv(here("DATA", "exam_data.txt"))
OurData
glimpse(OurData)
head(OurData)
tail(OurData)
view(OurData)

#<<<<<<< DLM
#Remove duplicates
OurData <- OurData %>%
  distinct()

#Endret fra 835 til 834 rader

#Variable types
#There are 28 variables
#Local and topical anestetics should be split into two variables and should be binary (logical)
#Preg.ended…37.wk should be logical not string
#Birth.outcome should be logical not string
#Completed.EDC should be logical not string
#EDC.necessary should be logical not string
#Same for ALL binary/factor/logical variables

OurData <- OurData %>%
  distinct()

