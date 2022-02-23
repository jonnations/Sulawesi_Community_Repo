# Sulawesi_Community_Repo
Data and Scripts for Sulawesi Murine Community Ecospace Project

This repo contains all the data and scripts for this project. There are many steps involved, from generating data to running predictive models to randomization analyses. Therefore, I will walk through the steps in this README. *Most scripts are heavily annotated*.

*Libraries Used in this Repo*: tidyverse, tidybayes, brms, pacman, purrr, furrr, dispRity, geomorph, PCDimension, phytools, vegan, picante. 

 - **Organize and Process Raw Data**

Most of the data in this project arrive here ready to go, including the stable isotope ratios and the external measurements. These data are stored in the directories `/~Isotope_Data` and `~/External_Measurement_Data` Subsequent data from models will be stored in these directories as well. The exception is the raw landmark data from the cranial and dentary CT scans. These are processed in `geomorph`. The raw landmark data, the scripts to process the data (`Landmark_Prep.Rmd` and `Landmark_Dent_Prep.Rmd`), the output files (PC scores, eigen values, and variance proportions) are in `~/Dentary_Data/dent_landmarks` and `~/Cranial_Data/landmarks`. The PC outputs for both files get updates with taxonomic and catalog info and moved into the broad data files. They are called `~/Dentary_Data/Dentary_PCA_Data_20axes.csv` and `~/Cranial_Data/Cranial_PCA_Data_36axes.csv`.

 - **Predicted Trait Values**
 
 To better leverage the sampling distributions of the data, and incorporate the intraspecific variance inherent in any species, we use a partial-pooling approach with Bayesian multilevel modeling to estimate trait value predictions for each species. 
 
For the Community Ecospace Variance values, all models and predictions are in the `Models_Fitted_Variance.Rmd` script. This includes Cranial shape & size, Dentary shape & size, external measurements, isotopes, and locomotion. The Community Ecospace Density models and predictions are in `Models_Fitted_Density.Rmd`.


 - ** Phylogenetic Diversity**
 
 Phylogenetic Diversity is estimated differently than trait data. I did this using picante. It has a built in function for estimating Faith's metric then generating the SES values. Script is called `Phylogenetic_Diversity.Rmd` and the data are in `~Phylogenetic_Diversity/`.


 - **Randomization and SES Values**
 
 


* Large Files stored with lfs. see instructions here:https://git-lfs.github.com/