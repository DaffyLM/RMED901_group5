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

#Count the different objects in different variables to see what to change to TRUE, FALSE, and see what values have NAs.
OurData %>%
  count(Asian)

OurData <- OurData %>%
  mutate(`Preg.ended<37wk` = case_when(
    `Preg.ended<37wk` == "Yes" ~ TRUE,
    `Preg.ended<37wk` == "No" ~ FALSE,
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

