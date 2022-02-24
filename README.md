# Sulawesi_Community_Repo
#################
######## AS OF 23 FEB, ALL VAR AND RANDO SCRIPTS WORK. LACKING REGRESSION SCRIPTS, PLOTTING SCRIPTS, AND CLADE ECOSPACE SCRIPTS.
########################
Data and Scripts for Sulawesi Murine Community Ecospace Project

This repo contains all the data and scripts for this project. There are many steps involved, from generating data to running predictive models to randomization analyses. I will walk through the steps in this README. *Most individual .Rmd scripts are heavily annotated*.

*Libraries Used in this Repo*: tidyverse, tidybayes, brms, pacman, purrr, furrr, dispRity, geomorph, PCDimension, phytools, vegan, picante, modelr, cmdstanr, and patchwork. 

This repo is meant to work in a certain order. All of the Predicted Data and Randomization Data winds up in a dataframe called `All_Traits.csv', which builds on itself. If working through it, please follow the order below. 

 - **Organize and Process Raw Data**

Most of the data in this project arrive here ready to go, including the stable isotope ratios and the external measurements. These data are stored in the directories `/~Isotope_Data` and `~/External_Measurement_Data` Subsequent data from models will be stored in these directories as well. The exception is the raw landmark data from the cranial and dentary CT scans. These are processed in `geomorph`. The raw landmark data, the scripts to process the data (`Landmark_Prep.Rmd` and `Landmark_Dent_Prep.Rmd`), the output files (PC scores, eigen values, and variance proportions) are in `~/Dentary_Data/dent_landmarks` and `~/Cranial_Data/landmarks`. The PC outputs for both files get updates with taxonomic and catalog info and moved into the broad data files. They are called `~/Dentary_Data/Dentary_PCA_Data_20axes.csv` and `~/Cranial_Data/Cranial_PCA_Data_36axes.csv`.

 - **Predicted Trait Values**
 
 To better leverage the sampling distributions of the data, and incorporate the intraspecific variance inherent in any species, I use a partial-pooling approach with Bayesian multilevel modeling to estimate trait value predictions for each species. 
 
For the Community Ecospace Variance values, all models and predictions are in the `Models_Fitted_Variance.Rmd` script. This includes Cranial shape & size, Dentary shape & size, external measurements, isotopes, and locomotion. The Community Ecospace Density models and predictions are in `Models_Fitted_Density.Rmd`.

The density script includes a broken stick estimation. Unlike sum of variance, nearest-neighbor density reqires all the axes together in one estimation. Therefore Ican't weight them. In order not to use extraneous PC axes in these analyses, I use a broken stick method to estimate the *significant* axes. In this case it's the first 2 for Cranial and first 3 for Dentary.


 - **Phylogenetic Diversity**
 
 Phylogenetic Diversity is estimated differently than trait data. I did this using picante. It has a built in function for estimating Faith's metric then generating the SES values. Script is called `Phylogenetic_Diversity.Rmd` and the data are in `~Phylogenetic_Diversity/`.


 - **Randomization and SES Values**
 
 The manuscript uses SES values for each trait for each community. These are the standard effect sizes - values of trait volumes and densities that account for the size of the community. The text has more details, but it's pretty standard practice. To do this, I wrote functions that generate 1000 fake communities using the independent swap algorithim. Then I estimate variance values for the traits for each of these communities. I take the mean and sd of these 1000 communities, and then subtract the observed variance value for each of the 1000 draws from the mean, then divide by the sd, resulting in 1000 SES values for each trait for each community. The Ecospace size/variance formulas are in the `Variance_Randomization.Rmd` script, and the Density formulas are in the `Density_randomization.Rmd` script. ***WARNING*** These randomization procedures take a long time! Using 6 cores on my M1 laptop, it can take 10-15 hours to run all of these. 
 
 
 - **Regression Analyses**
 
 The script `Regression_Analyses.Rmd` contains regression analyses for all SES variables. Each model uses n-species as the predictor, and ecospace volume or density, including the standard error of the measurement, as the response. More details are in the text. The continuous traits are in the first portion, followed by the discrete locomotion, and the phylogenetic diversity estimations (neither are probability distributions).
 

All of the Predicted and SES values are saved together in a dataframe called `All_Traits.csv` in the main directory. 


* Large Files stored on GitHub with lfs. See instructions here:https://git-lfs.github.com/