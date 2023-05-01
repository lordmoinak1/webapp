<!-- ## About

This app demonstrates using R shiny to dynamically visualize 3D/4D medical imaging data in the conventional way. It offers a basic yet useful tool for researchers and clinicians to quickly check MRI data inside a browser. More importantly, the mechanism we used here can be used to visualize any 3D voxel data. Here we are using MRI images as an example because this is a well-known format for the public and it's fun to play with.

This app provides two modes to visualize the data. In the first mode, you can play the images like a movie. We call it "animation" mode. Behind the scene, the images are rendered into pngs under a different environment (See `lazyr.R`). Therefore, we can enjoy the ultimate streaming speed provided by `renderImage` while the main Shiny thread won't get blocked when generating those plots. This is different from the strategy of [promises](https://rstudio.github.io/promises/index.html) as promises is [good for "a few operations that take a long time" while we have "lots of little operations that a bit slow"](https://rstudio.github.io/promises/articles/intro.html). 

In the second mode, you can play with the app interactively by clicking a point on any of the three plots. This 3D position will then be mapped to the other two plots and show you the cross-sectional picture of that point in the 3D space (indicated by the crosshair). In our field, clinicians uses this to diagnostic cerebrovascular diseases or other things like white matter disease. 

If you check the source code of `app.R`, you will see the app itself is very small. The truth is that this time we also wraped up the two modes I just described as [shiny modules](https://shiny.rstudio.com/articles/modules.html). In the near future, we will release this two modules as a separate R package so people can use them more easily. 

## Credits
This project was originally developed by the Biostats and Data Science Group at [Marcus Institute](https://www.marcusinstituteforaging.org/) (previously *Institute for Aging Research*) as a side project for [Dr. Lew Lipsitz](https://www.marcusinstituteforaging.org/scientists/team-profiles-and-bios/lewis-lipsitz-md)'s Cerebrovascular Mechanism of Slow Gait & Fall study (Grant: 5R01-AG041785-03). [Nischal Chand](https://github.com/DarkestFloyd), who was an intern in our group, contributed a lot to this project and came up with the idea of using another environment to improve the performance. Deeply appreciated!

The original plotting design and the idea of making it dynamic was inspired by [John Muschelli](https://twitter.com/StrictlyStat)'s [neurobase](https://CRAN.R-project.org/package=neurobase) package. The Demo MRI image data were downloaded from the [UCLA Consortium for Neuropsychiatric Phenomics LA5c Study](https://openneuro.org/datasets/ds000030/versions/00016) [https://doi.org/10.12688/f1000research.11964.2](https://doi.org/10.12688/f1000research.11964.2). In this example, we are using [Jon Clayden](https://twitter.com/jonclayden)'s [RNifti](https://cran.r-project.org/web/packages/RNifti/index.html) package to read in the data as it is literally blazing fast. 

Authors:
- Hao Zhu
- Nischal Mahaveer Chand
- Thomas Travison -->

<p align="center">
  <img src="/srv/shiny-server/student_apps/moinak_shiny_server/shinyMRI-contest/www/sbu_logo.png" width="125" height="125" title="hover text">
  <img src="/srv/shiny-server/student_apps/moinak_shiny_server/shinyMRI-contest/www/sbumedicine_logo.jpg" width="125" height="125" alt="accessibility text">
  <img src="/srv/shiny-server/student_apps/moinak_shiny_server/shinyMRI-contest/www/imaginelab_logo.png" width="125" height="125" alt="accessibility text">
</p>

# About me
Developed by [Moinak Bhattacharya](https://sites.google.com/view/moinakb) for BMI 530 project (Instructors: [Dr. Alisa Yurovsky](https://scholar.google.com/citations?user=9517icQAAAAJ&hl=en) and [Dr. Richard Moffitt](https://med.emory.edu/departments/hematology-medical-oncology/profile/?u=RAMOFFI)) and also towards his dissertation (Advisor: [Dr. Prateek Prasanna](https://prateekprasanna.com/)).

# Methods
<p align="center">
  <img src="/srv/shiny-server/student_apps/moinak_shiny_server/shinyMRI-contest/www/eyegaze_fig1.png" width="500" height="250">
</p>

# Limitations (for now)
1. rsconnect/shinyapps.io/lordmoinak/shinyMRI-contest.dcf -> https://lordmoinak.shinyapps.io/shinyMRI-contest/ | Upgrade to a professional account ($200) till then running locally.
2. Downloading the any one of the TCIA datasets and saving them in '.nii.gz' format requires a lot of space. Hence, for demonstration purpose, I am showing 10 patients for each dataset.