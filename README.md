#Getting and Cleaning Data Course Project

---
title: "README.md"

author: "José Enrique Álvarez"

date: "21 de agosto de 2014"

---

### Introduction

This repository is hosting the R code for the assignment of the DataScience track's "Getting and Cleaning Data" course which will be peer assessed.

The purpose of this project is to demonstrate ability to collect, work with, and clean a data set.

### Data Set

Here are the data for the project: 

[DataSet](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data linked represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

### Execution and files

The __run_analysis.R__ is the script that has been used for this work. It can be loaded in R/Rstudio and executed without any parameters.

The script donwloads and unzip the dataset.

The __CodeBook.md__ describes the variables, the data, and the work that has been performed to clean up the data.

The result of the execution is that a __tidy.txt__ file is being created, that stores the data for later analysis.