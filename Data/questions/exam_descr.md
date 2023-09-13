# Exam description

Practical task in groups (4-5 persons). 

You will create a GitHub repository or use the one you have created during the
course. There, you need to collaborate, keep history of changes, push commits,
etc. The log will be evaluated by us to check that each of you worked on a part
of the final report.

The repository should contain:

- _any scripts you have been using during the course_ (choose one version or
create a new one based on everyone's versions)
- _any notes or log files you think were useful_
- _the .Rproj file_
- _nice folder structure_
- _final .Rmd report and the .html or .md output_

## Data

You will receive an `exam_data.txt` file and the codebook describing the dataset
(`codebook_exam_data.html`).

## Tasks

1. Create an RStudio project.

    - create a nice folder structure, e.g., data, scripts folders, and put the
    dataset in `data`, create a new R script or Rmarkdown file in `scripts`
    - write a README and update its content as you go on

2. Day 5: Read and tidy the dataset.    
_(try to divide this task between the group members)_

    - write all the commands and document!
    - _tips:_
    
        - some columns may need to be separated
        - some columns can be duplicated
        - some column names can contain spaces or start with numbers
        - some columns can include values from various features/measurements

3. Day 6: Tidy, adjust, and explore.    
_(try to divide this task between the group members)_

    - Remove unnecessary columns from your dataframe: `year, month`
    - Read and join the additional dataset to your main dataset.
    - Make necessary changes in variable types
    - Create a set of new columns:
        - a column showing enrollment center as a character/factor instead of numbers
        - a column showing division of "Birthweight" over "GA.at.outcome"
        - a column cutting the BMI into quartiles (4 equal parts); HINT: cut() function
        - a column showing whether "number of qualifying teeth" was less than 15
    - Set the order of columns as: `PID, center, Group, BMI, Age` and other columns
    - Arrange PID column of your dataset in order of increasing number or alphabetically.
    - Connect above steps with pipe.
    - Explore your data.
    - Explore and comment on the missing variables.
    - Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
    - Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use pipe!
        - Only for persons with BMI <= 30
        - Only for persons older than 25
        - Only for persons classified as "Black"
        - Only for persons enrolled in NY (1)
    - Use two categorical columns in your dataset to create a table (hint: ?count)

4. Day 7: Create plots that would help answer these questions:
_(each person chooses min.one question)_

    - Are there any correlated measurements?
    - Does the serum measure for Interleukin(IL)-6 at baseline distribution depend on `Race`?
    - Does the serum measure for Interleukin(IL)-6 at baseline distribution depend on `Age`?
    - Does whether patient required essential dental care change with age of the patients?
    - Do BMI and age have a linear relationship?

4. Day 8: Analyse the dataset and answer the following questions:
_(each person chooses one question)_

    - Does the birth outcome depend on the center?
    - Does the birth outcome depend on BMI of the patient?
    - Is there an association between treatment and birthweight? 
    - According to the data, was there a difference of birthweight between different race categories? 

5. Write a short report in an Rmd format.    
_(divide writing the report)_

General tips:

- document, track changes (commit often!)
- use descriptive names, don't cram the code on a small space
- be active with commiting, commenting, etc.
- you can have many short scripts - one per each task, or two-three longer 
scripts logically divided and neatly commented

## What can be used?

Everything! Google if you get stuck, use books, blogs, R-docs...!

_NB: if you have any technical issues, contact us!_

## Evaluation

- We expect a clean history of changes and a nice structure of files.
- Documentation of the scripts needs to be informative.
- The code style will not be evaluated, but might influence our mood while
performing evaluation ;)
- In the end, we would like to receive a repository that includes:

    - README file
    - input data (and any other data if you generated during the coding)
    - scripts where you were trying things out
    - final .Rmd report (you may also include .html output or we can knit it ourselves)
    - any documentation files, if you chose to have those
    - .Rproj file

## Grading

The project will be evaluated individually and you will get
an exhaustive description of your work, taking into account:

    - cleanliness of the files and file structure,
    - usage of the functions to complete the tasks described above,
    - the overall content of the final report.


