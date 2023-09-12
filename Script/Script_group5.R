library(tidyverse)
library(here)
#<<<<<<< Branch_Mathilde
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


#Variable type changes
##PID, mounth, year and age to integer
##Black, white, Nat.Am, Asian, Hisp to logical
##BMI to integer
##Hypertension, diabetes to logical
##BL.Diab.Type to factor

OurData %>% 
  glimpse()
# Local_Topical.Anest is also combined, with information on both Local and Topical Anesthetic 

OurData <- OurData %>%
  separate (col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"),
            sep = "_")
# Changed column Local_Topical.Anest with combined variables to two different variables. 

OurData %>% 
  glimpse()


#Remove duplicates
OurData <- OurData %>%
  distinct()

#Endret fra 835 til 834 rader
#Endret fra 835 til 834 rader

#Variable types
#There are 28 variables
#Local and topical anestetics should be split into two variables and should be binary (logical)
#Preg.ended…37.wk should be logical not string
#Birth.outcome should be logical not string
#Completed.EDC should be logical not string
#EDC.necessary should be logical not string
#Same for ALL binary/factor/logical variables
