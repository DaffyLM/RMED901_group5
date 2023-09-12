#<<<<Joanna branch>>>>>>
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

naniar::gg_miss_var(OurData)

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





