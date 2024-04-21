# Run Everything in Background

library('rmarkdown', 'here')

#here::i_am('Code/Run_All.R')

render(here::here("Code", "Models_Fitted_Variance.Rmd"))

render(here::here("Code", "Models_Fitted_Density.Rmd"))
# After this, adat has 39 colnames:
# .draw, vcCsize, cv_wei, com, vdCsize, dv_wei, vHB, vTail, vHF, vEar, vMass, mHB_pos, mTail_pos, mHF_pos, mEar_pos, mMass_pos, ext_sum, ext_scaled, vN15, vC13, sk_var, iso_var, morpho_var, c_nn, csize_nn, d_nn, dsize_nn, sk_nn, HB_nn, Tail_nn, HF_nn, Ear_nn, Mass_nn, Bsz_nn, ext_nn, morpho_nn, N15_nn, C13_nn, iso_nn

# Remove all the objects in the environment
rm(list = ls())

render(here::here("Code", "Randomization_Variance.Rmd"))
# adds vBsz upon loading
# ends with 56 variables:
# added vBsz, ses_vHB, ses_vHF, ses_vTail, ses_vEar, ses_vMass, ses_vBsz, ses_ext, ses_cv_wei, ses_vcCsize, ses_dv_wei, ses_vdCsize, ses_vsk, ses_morpho, ses_vC13, ses_vN15, ses_vIso

# Remove all the objects in the environment
rm(list = ls())

render(here::here("Code", "Randomization_Density.Rmd"))
# Now 72 variables:
# added nnses_c, nnses_d, nnses_csize, nnses_dsize, nnses_sk, nnses_Bsz, nnses_Tail, nnses_HF, nnses_Ear, nnses_HB, nnses_Mass, nnses_ext, nnses_morpho, nnses_C13, nnses_N15, nnses_iso

# Remove all the objects in the environment
rm(list = ls())

render(here::here("Code", "Randomization_Density_Constrain.Rmd"))

# 88 variables in adat
# added c_nnses_c, c_nnses_d, c_nnses_csize, c_nnses_dsize, c_nnses_sk, c_nnses_Bsz, c_nnses_Tail, c_nnses_HF, c_nnses_Ear, c_nnses_HB, c_nnses_Mass, c_nnses_ext, c_nnses_morpho, c_nnses_C13, c_nnses_N15, c_nnses_iso

# Remove all the objects in the environment
rm(list = ls())

render(here::here("Code", "Regression_Analyses.Rmd"))

# Remove all the objects in the environment
#rm(list = ls())

render(here("Code", "Regression_Analyses_Constrain.Rmd"))


