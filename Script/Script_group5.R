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

#Endret fra 835 til 834 rader

#Variable types
#There are 28 variables
#Local and topical anestetics should be split into two variables and should be binary (logical)
#Preg.ended…37.wk should be logical not string
#Birth.outcome should be logical not string
#Completed.EDC should be logical not string
#EDC.necessary should be logical not string
#Same for ALL binary/factor/logical variables

#Read the join data
OurData_join <- read_tsv(here("Data", "exam_data_join.txt"))

#Join the new dataset with the "old"
OurData <- OurData %>%
  full_join(OurData_join, by = join_by(PID))

#Rename the new variables O61 and O81
OurData <- 
  OurData %>%
  rename(IL6_baseline = O61)

OurData <-
  OurData %>%
  rename(IL8_baseline = O81)

OurData %>% 
  glimpse()
