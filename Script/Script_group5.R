
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

#Variable types
#There are 28 variables
#Local and topical anestetics should be split into two variables and should be binary (logical)
#Preg.ended…37.wk should be logical not string
#Completed.EDC should be logical not string
#EDC.necessary should be logical not string
#Same for ALL binary/factor/logical variables

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

#Count the different objects in different variables to see what to change to TRUE, FALSE, and see what values have NAs.
OurData %>%
  count(Asian)

OurData <- OurData %>%
  mutate(Preg.ended_bf37 = case_when(
    Preg.ended_bf37 == "Yes" ~ TRUE,
    Preg.ended_bf37 == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(Completed.EDC = case_when(
    Completed.EDC == "Yes" ~ TRUE,
    Completed.EDC == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(EDC.necessary. = case_when(
    EDC.necessary. == "Yes" ~ TRUE,
    EDC.necessary. == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(TopicalAnesthetic = case_when(
    TopicalAnesthetic == "Yes" ~ TRUE,
    TopicalAnesthetic == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(LocalAnesthetic = case_when(
    LocalAnesthetic == "Yes" ~ TRUE,
    LocalAnesthetic == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(Hypertension = case_when(
    Hypertension == "Y" ~ TRUE,
    Hypertension == "N" ~ FALSE)) %>%
  mutate(Diabetes = case_when(
    Diabetes == "Yes" ~ TRUE,
    Diabetes == "No" ~ FALSE)) %>%
  mutate(Black = case_when(
    Black == "Yes" ~ TRUE,
    Black == "No" ~ FALSE)) %>%
  mutate(White = case_when(
    White == "Yes" ~ TRUE,
    White == "No" ~ FALSE)) %>%
  mutate(Nat.Am = case_when(
    Nat.Am == "Yes" ~ TRUE,
    Nat.Am == "No" ~ FALSE)) %>%
  mutate(Hisp = case_when(
    Hisp == "Yes" ~ TRUE,
    Hisp == "No" ~ FALSE,
    TRUE ~ NA)) %>%
  mutate(Asian = case_when(
    Asian == "Yes" ~ TRUE,
    Asian == "No" ~ FALSE,
  ))

# Explore and comment on the missing variables:
naniar::gg_miss_var(OurData)
# See which variables have missing values with naniar. BL.Diab.Type has the most. Tx.time, Tx.comp. and so on have also many missing. 
OurData %>%
  count(BL.Diab.Type)
#Use count to see exactly how many missing in the different variables.
naniar::gg_miss_var(OurData, facet = Diabetes)
#Explore missing variables by different cat. All missing values in BL.Diab.Type are in participants without diabetes.

OurData %>%
  group_by(EDC.necessary.) %>%
  summarise(min(Birthweight, na.rm = T),
          max(Birthweight, na.rm = T),
          mean(Birthweight, na.rm = T),
          sd(Birthweight, na.rm = T))

OurData %>%
  group_by(EDC.necessary.) %>%
  filter(substr(PID, 1, 1) == 1) %>%
  filter(BMI <= 30) %>%
  filter(Age > 25) %>%
  filter(Black = TRUE) %>%
  summarise(min(Birthweight, na.rm = T),
            max(Birthweight, na.rm = T),
            mean(Birthweight, na.rm = T),
            sd(Birthweight, na.rm = T))

count_table <- OurData %>%
  count(EDC.necessary., Black)
count_table
