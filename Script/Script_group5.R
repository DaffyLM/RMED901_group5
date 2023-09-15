# Script_group5
# Created 2023-09-12


library(tidyverse)
library(here)
library(patchwork)
library(GGally)

#Read data
OurData <- read_tsv(here("Data", "exam_data.txt"))



#Explore
summary(OurData)
glimpse(OurData)
View(OurData)        
skimr::skim(OurData) 
naniar::gg_miss_var(OurData)



#Read the join data
OurData_join <- read_tsv(here("Data", "exam_data_join.txt"))




#Tidying OurData
OurData <- OurData %>%
  rename(BMI = `BMI kg/m2`,
         Preg.ended_bf37 = `Preg.ended<37wk`) %>% #renamed variables
  separate(col = Local_Topical.Anest, into = c("LocalAnesthetic", "TopicalAnesthetic"), sep = "_") %>% # Changed column Local_Topical.Anest with combined variables to two different variables. 
  distinct() %>% #Removed duplicates 
  mutate(C = case_when(C == TRUE ~ "C",
                     TRUE ~ "T")) %>% #Converted column C to either C or T
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


#Cannot merge the race variables as they are not dependent of each other, created additional category.
OurData <- OurData %>%
  mutate(race = case_when(Black & !White & !Nat.Am & !Asian & !Hisp ~ "Black",
                          !Black & White & !Nat.Am & !Asian & !Hisp ~ "White",
                          !Black & !White & Nat.Am & !Asian & !Hisp ~ "Nat.Am",
                          !Black & !White & !Nat.Am & Asian & !Hisp ~ "Asian",
                          !Black & !White & !Nat.Am & !Asian & Hisp ~ "Hisp",
                          TRUE ~ "Mixed")
  )



#Create new tidy dataset
write_delim(OurData, file = here("Data", "tidy_exam_data.txt"))



#Explore missing variables
naniar::gg_miss_var(OurData)
# BL.Diab.Type has the most NAs. Tx.time, Tx.comp. and so on have also many missing.

OurData %>%
  count(BL.Diab.Type) #Use count to see exactly how many missing in the different variables.

OurData %>% 
  summarise_all(~sum(is.na(.))) %>% 
  gather(variable, na_count) %>%
  filter(na_count > 0) # count all missing in different variables.

#Explore missing variables by different cat. 
# All missing values in BL.Diab.Type are in participants without diabetes.
naniar::gg_miss_var(OurData, facet = Diabetes)



# Statify by a categorical column (group), report descriptive statistics
OurData %>% 
  group_by(Group) %>%
  summarise(min_age = min(Age, na.rm = TRUE),
            max_age = max(Age, na.rm = TRUE),
            mean_age = mean(Age, na.rm = TRUE),
            sd_age = sd(Age, na.rm = TRUE))



#Stratify data by a categorical column (group), with several conditions, descriptive stat.
OurData %>% 
  filter(BMI <= 30) %>%
  filter(Age > 25) %>%
  filter(race == "Black") %>%
  filter(Enroll.Center == "NY" ) %>%
  group_by(Group) %>%
  summarise(min_birthweight = min(Birthweight, na.rm = TRUE),
            max_birthweight = max(Birthweight, na.rm = TRUE),
            mean_birthweight = mean(Birthweight, na.rm = TRUE),
            sd_birthweight = sd(Birthweight, na.rm = TRUE)) 



#Use two categorical columns in the dataset to create a table
OurData %>% 
  count(Enroll.Center, Group)




#Creating plots

#Visualize multiple correlations.
multiple_correlations_plot <- ggpairs(OurData[c("BMI", 
                                                "Age", 
                                                "Education", 
                                                "GA.at.outcome", 
                                                "Birthweight",
                                                "IL6_baseline",
                                                "IL8_baseline")])

multiple_correlations_plot



#Check if interleukin(IL)-6 at baseline distribution depend on Race
ggplot(data=OurData) +
  aes(y = IL6_baseline) +
  geom_boxplot(aes(color = race)) +
    facet_grid(rows = vars(race)) +
  coord_cartesian(ylim= c(0, 100))

#Check if interleukin(IL)-6 at baseline distribution depend on Age
#Age
IL_6_baseline_Age <- ggplot(OurData,
                            aes(x = as.factor(Age), y = IL6_baseline)) +
  geom_point()+
  theme_minimal()+
  labs(title = "Interleukin(IL)-6 distribution vs. Age")
IL_6_baseline_Age

# Age_group
OurData$Age_group <- cut(OurData$Age, breaks = c(0, 16, 21, 26, 31, 36, 44), 
                         labels = c("16-20", "21-25", "26-30", "31-35", "36-40", "41-44"))

IL_6_baseline_Age_group <- ggplot(OurData %>%
                                    filter(!is.na(Age_group)),
                                  aes(x = as.factor(Age_group), y = IL6_baseline)) +
  geom_boxplot(aes(color = Age_group))+
  theme_minimal()+
  labs(title = "Interleukin(IL)-6 distribution vs. Age_group")
IL_6_baseline_Age_group



#Check Proportion of Patients Requiring EDC by Age
data_for_plot <- OurData %>% 
  filter(EDC.necessary. == TRUE) %>%
  group_by(Age) %>%
  summarise(count = n()) %>%
  mutate(proportionEDC = count/sum(count))  



# Plotting
ggplot(data_for_plot, aes(x=Age, y=proportionEDC)) + 
  geom_bar(stat="identity", fill="orange") + 
  labs(title="Proportion of Patients Requiring EDC by Age",
       x="Age",
       y="Proportion of Patients") +
  theme_minimal()



# Check for linear relationship between age and BMI
scatter_plot_BMI_Age <- ggplot(OurData, 
                               aes(x = Age, y = BMI))+
  geom_point()+
  geom_smooth(method = "lm", color = "red") +
  theme_minimal() +
  labs(title = "Scatter Plot of Age vs. BMI")

scatter_plot_BMI_Age





# Analyses
  
#Check if birthweight is dependent on the center (we changed from birth outcome to birthweight to be able to do an ANOVA-test)
Enroll.Center_birthweight <- ggplot(OurData,
                                    aes(x = Enroll.Center, y = Birthweight, fill = Enroll.Center)) +
  geom_boxplot(aes(color = Enroll.Center)) +
  theme_minimal() +
  labs(title = "Enroll.Center vs. birthweight")
Enroll.Center_birthweight


#ANOVA for Enroll.Center and Birthweight
OurData %>%
  aov(Birthweight~Enroll.Center, data = .) %>%
  broom::tidy()






#Check if birth outcome depend on BMI. Check distribution of BMI
Hist_BMI_Birth.outcome <- ggplot(OurData, aes(x=BMI)) +
  geom_histogram(aes(fill=Birth.outcome), bins=30, alpha=0.7, position="identity") + 
  facet_wrap(~ Birth.outcome, scales="free_y") +
  labs(title="Distribution of BMI by Birth Outcome", 
       x="BMI", y="Count") +
  theme_minimal()

print(Hist_BMI_Birth.outcome)

#BMI is not normally distributed - use Kruskal-Wallis test
OurData %>% 
  kruskal.test(Birth.outcome~BMI, data = .) %>%
  broom::tidy()





#Check association between treatment and birthweight 
ggplot(OurData, aes(x = Group, y = Birthweight, fill = Group)) +
  geom_boxplot() +
  labs(title = "Comparison of Birthweight between Groups C and T",
       x = "Group",
       y = "Birthweight") +
  theme_minimal()

#T-test
OurData %>% 
  t.test(Birthweight~Group, data = .) %>%
  broom::tidy()




#Check if there is a difference of birthweight between different race categories 
#Check for normality
OurData %>%
  ggplot(aes(x=Birthweight, 
             color=as.factor(race),
             ))+
  geom_histogram() 

#The ANOVA
ANOVAresultraceBW <- OurData %>%
    aov(Birthweight~ race, data = .) %>%
  broom::tidy()

#Plots
ggplot(data=OurData) +
  aes(x = Birthweight) +
  geom_boxplot(aes(color = race)) +
  facet_grid(rows = vars(race))