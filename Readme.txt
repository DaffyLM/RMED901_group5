Created 2023-09-07
Last updated 2023-09-15
Group 5: Dagfinn, Joanna, Ingvild, Mathilde
---------------------------------

RMED901_group5 project for RMED901 Data science with R for medical researchers

---------------------------------

File structure:
-RMED901_group5
|--Readme.txt
|--Data
|---exam_data_join.txt
|---exam_data.txt
|---tidy_exam_data.txt
|--Script
|---Script_group5.R
|--RMarkdown
|---2023-09-15_RMarkdown_group5
|---2023-09-15_RMarkdown_group5.Rmd
|--RMED901.Rproj

----------------------------------

Table of Contents:
|--Data deccription
|--Script Overview
|--Data Cleaning and Manipulation
|--Data Exploration
|--Visualization
|--Notes
|--Requirements

---
Data description: 
The data are derived from a randomized controlled trial examining whether treatment of maternal periodontal disease can reduce risk of preterm birth and low birth weight.
---
Script Overview:
Data Import:
The main dataset was exam_data.txt. An additional dataset (exam_data_join.txt) was imported and joined with the main dataset based on the Patient ID (PID). After cleaning the merged dataset, a new file called tidy_exam_data.txt was created and subsequent analyses were conducted using this dataset.

---
Data Cleaning and Manipulation:
Several variables are renamed for clarity and consistency.
The column Local_Topical.Anest which had combined variables, is separated into two distinct variables: LocalAnesthetic and TopicalAnesthetic.
Duplicate entries are identified and removed.
The treatment groups were represented in two coloumns, C and T. The C column is transformed to have values "C" or "T" and subsequently renamed to "Group".
Unwanted columns like year, month, and T were removed.
Values in the Education column are modified for clarity, removing "yrs" and replacing "MT" and "LT" with ">" and "<" respectively.
Boolean columns are created or modified, transforming string values like "Yes" and "No" to TRUE and FALSE respectively.
New columns are derived, such as one indicating if the number of qualifying teeth is less than 15.
The PID is separated to also include the enrollment center.
Variables like BMI are grouped into quartiles.
Finally the cleaned dataset was saved as tidy_exam_data.txt
---
Data Exploration:
Missing data points are analyzed and reported.
Summary statistics for various variables, stratified by categories like race, are computed.
Data is aggregated to understand patterns and distributions.
---
Visualization:
Several plots are created to explore and answer specific research questions:
Correlation between measurements.
Dependence of the serum measure for Interleukin(IL)-6 at baseline on race and age.
Analysis of patients requiring essential dental care as they age.
Exploration of the linear relationship between BMI and age.
---
Notes:
In total, 140 had submitted more than one 'race' catogory. This category was therefore merged to 'White', 'Black', 'Nat.Am', 'Asian', and 'Hisp' for subjects that submitted only one response, and 'Mixed' for subjects with >1 response. 
Mann Whitney U tests were used to compare differences in birthweight between two groups in the dataset as the birthweight was not normally distributed.
---
Requirements:
For this script, the following libraries are required:
tidyverse
here
patchwork
skimr
naniar
ggplot2
GGally

