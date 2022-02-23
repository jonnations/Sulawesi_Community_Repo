# Sulawesi_Community_Repo
Data and Scripts for Sulawesi Murine Community Ecospace Project

This repo contains all the data and scripts for this project. There are many steps involved, from generating data to running predictive models to randomization analyses. Therefore, I will walk through the steps in this README. Most scripts are heavily annotated.

 - Libraries Used in this Repo :
tidyverse, tidybayes, brms, pacman, purrr, furrr, dispRity, geomorph, PCDimension. 

 - Organize and Process Raw Data

Most of the data in this project arrive here ready to go, including the stable isotope ratios and the external measurements. These data are stored in the directories `/~Isotope_Data` and `~/External_Measurement_Data` Subsequent data from models will be stored in these directories as well. The exception is the raw landmark data from the cranial and dentary CT scans. These are processed in `geomorph`. The raw landmark data, the scripts to process the data (`Landmark_Prep.Rmd` and `Landmark_Dent_Prep.Rmd`), the output files (PC scores, eigen values and varaince proportions) are in `~/Dentary_Data/dent_landmarks` and `~/Cranial_Data/landmarks`.

