---
title: Data and Scripts for ***Trait-specific patterns of community ecospace occupancy in an insular mammal radiation***
output:
  html_document: default
---
#########################
#UPDATES
# realized that the problem I was having with the # of axes is because I was SCALING all my PC axes to N(0,1)! THis means that multiplying by the variance was basically just putting them back on their original scale!

# The big question everyone has: What regions are taken up by the more diverse communities? I'm not sure how to calculate this. A distribution of the means of each measurement is one way. Tail value example, If a mean is near 0 for a low-rich communitiy and 0.5 for a high rich, and the community is expanding, this means that there are more long tailed species in the high richness community. 
RETHINK THIS : what the mean is showing is the difference between the mean of all the species pooled together and the mean of the community. Am i more interested in the differences in the means of the small communities vs the means of the large communities?

The disparity Metric of Guillerme gives the distance from 0, but tells nothing of the directionality, so that's out. 
#
#
#
# Other Thing - for clades, instead of verbally talking about how clades occupy different space, I can calculate the displacement values for each clade. This is the ratio between the distance to the centroid (see centroids above) and the distance from a reference.
# Not sure this is best, couldn't I just estimate the mean from the centroid for each species? (or is that bogus with PCA?)
#


<br>
<br>
Zenodo upload to be associated with the Dryad Repo. 

This repo contains all the data and scripts for this project. There are many steps involved, from generating data to running predictive models to randomization analyses. I will walk through the steps in this README. *Most individual .Rmd scripts are heavily annotated*.

***Libraries Used in this Repo***: here, tidyverse, tidybayes, brms, pacman, purrr, furrr, dispRity, geomorph, PCDimension, phytools, vegan, picante, modelr, cmdstanr, ggstar, and patchwork. 

- All of these packages should be available in CRAN. See the brms [FAQ](https://github.com/paul-buerkner/brms#faq) for details on installing Stan, cmndstanr, and brms

## Layout 

  There are 12 main directories in this repo. Each of the scripts call from these directories and then put the outputs into them.
  
  Four of the Directories strictly hold input and outputs for trait data (`Cranial_Data`, `Dentary_Data`, `External_Measurement_Data`, `Isotope_Data`, `Locomotor_Data`). These just get called into the scripts, where things are done to them, and then the outputs go back into these directories. The `Phylogenetic_Diversity` directory holds the data for those analyses. Though it works a bit differently, it is analagous to one of the aforementioned trait directories.
  
  All of the scripts that *do things* are in the directory `Code`. Here are the markdown files that execute the meat of the project. There are some descriptions below. Also in here are the scripts I used to make many of the figures in the paper. Some of the plotting scripts required pretty extensive data manipulation, so I keep them in here. The figure outputs go into the `Plots` directory. For each SES values for each trait, a regression analysis is run using the trait SES value as the response, and the number of species in the community as the predictor. These are measurement error models, so they use the standard error of the trait SES estimates as well. All of the regressions were run in a single go using `purrr` and some other cool packages. All of this is in the `Regression_Analyses.Rmd` script in the `Code` directory.
  
  The last remaining directories are mostly places to keep things. `Species_Data` holds some lists of species and communities, all in `Rdata` format, as well as a color palette. `Plots` holds the plotting outputs. `Regression` hold the regression model outputs, and `Models` holds the brms model outputs. These models and plots are really big files, so I am not including them, but running the `Models_Fitted_Variance.Rmd` and `Models_Fitted_Variance.Rmd` scripts will populate the `Model` directory for you, and the plots are in the text and supporting materials.

## Order of Operations
  
This repo is meant to work in a certain order. All of the Predicted Data and Randomization Data winds up in a dataframe called `All_Traits.csv', which builds on itself. If working through it, please follow the order below. 

This repo is set up using the R Package `here`. If installed and loaded, the scripts should run on your machine and generate these files in the directories in this repo. 

 - **Organize and Process Raw Data**

Most of the data in this project arrive here ready to go, including the stable isotope ratios and the external measurements. These data are stored in the directories `/~Isotope_Data` and `~/External_Measurement_Data` Subsequent data from models will be stored in these directories as well. The exception is the raw landmark data from the cranial and dentary CT scans. These are processed in `geomorph`. The raw landmark data, the scripts to process the data (`Landmark_Prep.Rmd` and `Landmark_Dent_Prep.Rmd`), the output files (PC scores, eigen values, and variance proportions) are in `~/Dentary_Data/dent_landmarks` and `~/Cranial_Data/landmarks`. The PC outputs for both files get updates with taxonomic and catalog info and moved into the broad data files. They are called `~/Dentary_Data/Dentary_PCA_Data_20axes.csv` and `~/Cranial_Data/Cranial_PCA_Data_36axes.csv`.

 - **Predicted Trait Values**
 
 To better leverage the sampling distributions of the data, and incorporate the intraspecific variance inherent in any species, I use a partial-pooling approach with Bayesian multilevel modeling to estimate trait value predictions for each species. 
 
For the Community Ecospace Variance values, all models and predictions are in the `Models_Fitted_Variance.Rmd` script. **RUN THIS FIRST** This includes Cranial shape & size, Dentary shape & size, external measurements, isotopes, and locomotion. 

The Community Ecospace Density models and predictions are in `Models_Fitted_Density.Rmd`. The density script includes a broken stick estimation. Unlike sum of variance, nearest-neighbor density requires all the axes together in one estimation. Therefore I can't weight them. In order not to use extraneous PC axes in these analyses, I use a broken stick method to estimate the *significant* axes. In this case it's the first 2 for Cranial and first 3 for Dentary. **RUN THIS SECOND**

- **Locomotor Diversity**

All of the locomotion data and outputs are stored in the `Locomotor_Diversity` directory. Locomotor Diversity is an ordinal trait, not a continuous trait, so this is estimated a little differently. There is no uncertainty, or intraspecific error in these 4 categories. Because of that, the variance and nearest neighbor is calculated for each community using each species values. This is done using `var()` and using `disparity()` like above. All these values are stored in a separate directory, and not added to the `All_Traits.csv` dataframe. There are some times where I manually add the Locomotor (and Phylogenetic Diversity) values to some dataframes. When I do it, I mention this in the scripts. It's mostly just adding the Regression outputs into the big regression output df.

 - **Phylogenetic Diversity** 
 
Phylogenetic Diversity is estimated differently than trait data. I did this using picante. It has a built in function for estimating Faith's metric then generating the SES values. Script is called `Phylogenetic_Diversity.Rmd` and the data are in `~Phylogenetic_Diversity/`.


 - **Randomization and SES Values**
 
 The manuscript uses SES values for each trait for each community. **THIS GETS RUN AFTER THE TWO PREDICTED TRAIT VALUES SCRIPTS**. These are the standard effect sizes - values of trait volumes and densities that account for the size of the community. The text has more details, but it's pretty standard practice. To do this, I wrote functions that generate 1000 fake communities using the independent swap algorithm. Then I estimate variance values for the traits for each of these communities. I take the mean and sd of these 1000 communities, and then subtract the observed variance value for each of the 1000 draws from the mean, then divide by the sd, resulting in 1000 SES values for each trait for each community. The Ecospace size/variance formulas are in the `Variance_Randomization.Rmd` script, and the Density formulas are in the `Density_randomization.Rmd` script. ***WARNING*** These randomization procedures take a long time! Using 6 cores on my M1 laptop, it can take 10-15 hours to run all of these. 
 
 
 - **Regression Analyses**
 
 The script `Regression_Analyses.Rmd` contains regression analyses for all SES variables. Each model uses n-species as the predictor, and ecospace volume or density, including the standard error of the measurement, as the response. More details are in the text. The continuous traits are in the first portion, followed by the discrete locomotion, and the phylogenetic diversity estimations (neither are probability distributions).
 

 - **Plots**
 
Figures 3, 4, 5, S3, S4, and S5 were made in R. The scripts are in this Repo. Figure 5 has some minor modifications that were done in afdesign, namely moving the legend a bit. Otherwise, they are all the same as these scripts produce. Fig S5 in particular has a lot of analyses that lead up to it, all of which are in the plotting script.
 

All of the Predicted and SES values are saved together in a dataframe called `All_Traits.csv` in the main directory. 


* Large Files stored on GitHub with lfs. See instructions here:https://git-lfs.github.com/
