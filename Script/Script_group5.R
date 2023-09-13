
# Script_group5
# Created 2023-09-12
# exam_data.txt file
# Day5 Exploring, Tidying 

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
naniar::gg_miss_var() %>%
  
#Piped the commands
OurData <- OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`) %>% #renamed variables
  separate(col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"), sep = "_") %>% # Changed column Local_Topical.Anest with combined variables to two different variables. 
  distinct() #Removed duplicates #Endret fra 835 til 834 rader

#Converted coloumn C to either C or T
OurData <- OurData %>%
  mutate(C = case_when(C == "TRUE" ~ "C",
                       TRUE ~ "T"))

OurData <- OurData %>% 
  rename(Group = C)
View(OurData)

# Remove columns `year` and `month` and 'T'
OurData <-
  OurData %>%
  select(-year, -month, -T)

#Cannot merge the race variables as they are not dependent of each other
OurData <- OurData %>%
  mutate(Education=str_replace(Education, "yrs", "")) %>%
  mutate(Education=str_replace(Education, "MT", ">")) %>%
  mutate(Education=str_replace(Education, "LT", "<"))
view(OurData)

#There are 28 columns and 835 rows
#Column type frequency:            
# character                15     
# logical                  2      
# numeric                  11  

# Comments: 
# C and T change NA to FALSE to remove missing data or combine C and T as one column 
# Education should be split and logical 
# Month and year should be combine as a date

# Variables:
# All variable with answer "Yes/No" should be logical "TRUE/FALSE"
# tx.time value should be integer

#<<<<<<< Branch_Mathilde


#Variable type changes
##PID, mounth, year and age to integer
##Black, white, Nat.Am, Asian, Hisp to logical
##BMI to integer
##Hypertension, diabetes to logical
##BL.Diab.Type to factor
#Variable types
#There are 28 variables
#Local and topical anestetics should be split into two variables and should be binary (logical)
#Preg.ended…37.wk should be logical not string
#Birth.outcome should be logical not string
#Completed.EDC should be logical not string
#EDC.necessary should be logical not string
#Same for ALL binary/factor/logical variables

