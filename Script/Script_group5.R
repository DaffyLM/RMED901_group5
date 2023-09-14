
# Script_group5
# Created 2023-09-12
# exam_data.txt file
# Day5 Exploring, Tidying 
#Last updated 2023-09-13 19:00

library(tidyverse)
library(here)
here()

OurData <- read_tsv(here("Data", "exam_data.txt"))
OurData
summary(OurData)
glimpse(OurData)
View(OurData)        
skimr::skim(OurData) 
naniar::gg_miss_var(OurData)
OurData_join <- read_tsv(here("Data", "exam_data_join.txt")) #Read the join data

#Piped the commands
OurData <- OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`) %>% #renamed variables
  separate(col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"), sep = "_") %>% # Changed column Local_Topical.Anest with combined variables to two different variables. 
  distinct() %>% #Removed duplicates #Endret fra 835 til 834 rader
  mutate(C = case_when(C == TRUE ~ "C",
                     TRUE ~ "T")) %>% #Converted coloumn C to either C or T
  rename(Group = C) %>% 
  select(-year, -month, -'T') %>%  # Remove columns `year` and `month` and 'T
  mutate(Education=str_replace(Education, "yrs", "")) %>%
  mutate(Education=str_replace(Education, "MT", ">")) %>%
  mutate(Education=str_replace(Education, "LT", "<")) %>% 
  full_join(OurData_join, by = join_by(PID)) %>% #Join the new dataset with the "old"
  rename(IL6_baseline = O61) %>% #Rename the new variables O61 and O81
  rename(IL8_baseline = O81) %>% 
  mutate(`Preg.ended_bf37` = case_when(
    `Preg.ended_bf37` == "Yes" ~ TRUE,
    `Preg.ended_bf37` == "No" ~ FALSE,
    TRUE ~ NA)) %>% #Changes in variable types
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
  )) %>% 
  mutate("NoQualTeeth<15" = if_else(N.qualifying.teeth <15, 0, 1)) %>% #A column showing whether "number of qualifying teeth" was less than 15
  separate(PID, into = c("Enroll.Center", "PID"), sep = 1) %>% #New column for enrollment center
  mutate(Enroll.Center = case_when(Enroll.Center == "1" ~ "NY",
                                   Enroll.Center == "2" ~ "MN",
                                   Enroll.Center == "3" ~ "KY",
                                   Enroll.Center == "4" ~ "MS")) %>% #Rename enrollment center as a character 
  select(PID, Enroll.Center, Group, BMI, Age, everything()) %>% # Order of columns: PID, Enroll.Center, Group, BMI, Age
  mutate(BMI_Quartile = cut(BMI, 
                            breaks = quantile(BMI, probs = c(0, 0.25, 0.5, 0.75, 1), na.rm = TRUE),
                            labels = c("Q1", "Q2", "Q3", "Q4"), 
                            include.lowest = TRUE)) %>% 
  arrange(desc(PID)) #Arrange PID column in order of increasing number alphabetically 

  
#Cannot merge the race variables as they are not dependent of each other

#Explore your data.
#Explore and comment on the missing variables.
#Stratify your data by a categorical column and report 
summary(OurData)

OurData %>% 
  filter(BMI <= 30) %>% 
  group_by(White) %>%
  summarise(min_age = min(Age, na.rm = TRUE),
            max_age = max(Age, na.rm = TRUE),
            mean_age = mean(Age, na.rm = TRUE),
            sd_age = sd(Age, na.rm = TRUE)) 
OurData %>% 
  summarise_all(~sum(is.na(.))) %>% 
  gather(variable, na_count) %>%
  filter(na_count > 0)  #Explore (and comment) on the missing variables

#Use two categorical columns in your dataset to create a table (hint: ?count)
OurData %>% 
  count(Enroll.Center, Group)

##Day 7: Create plots that would help answer these questions:(each person chooses min.one question)_

#Are there any correlated measurements?
  #Does the serum measure for Interleukin(IL)-6 at baseline distribution depend on `Race`?
  #Does the serum measure for Interleukin(IL)-6 at baseline distribution depend on `Age`?
  #Does whether patient required essential dental care change with age of the patients?
  #Do BMI and age have a linear relationship?
  
