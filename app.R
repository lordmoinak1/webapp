library(shiny)
library(RNifti)
library(shinythemes)
library(shinyWidgets)
library(markdown)
source("lazyr.R")
source("interactive.R")
source("animation.R")

read_img_as_array <- function(path) {
  print(path)
  img_raw <- RNifti::readNifti(path)
  if (length(dim(img_raw)) == 3) return(img_raw[,,])
  return(img_raw[,,,])
}

ui <- navbarPage(
  "BMI 530 CT visualization",
  # img(src="sbu_logo.png", style="float:right; padding-right:25px"),
  # title = div(img(src="sbu_logo.jpg"), "BMI 530 CT visualization"),
  # tags$li(div(img(src='sbu_logo.jpg', title = "A Test", height = "30px"), style = "margin-left:1100px; margin-top:-25px; padding-top:-50px; padding-right:10px;"), class = "dropdown"),
  theme = shinytheme("slate"),
  tabPanel(
    "Home",
    fluidRow(
      column(2, selectInput(
        "demo_dt", "Choose a TCIA cohort", choices = c(
          "LIDC IDRI" = "data/lidc_idri",
          "NSCLC Radiogenomics" = "data/nsclc_radiogenomics",
          "NSCLC-Radiomics" = "data/nsclc_radiomics.nii.gz",
          "NSCLC-Radiomics-Interobserver1" = "data/nsclc_radiomics_interobserver",
          "Pediatric-CT-SEG" = "data/pediatric_ct_seg",
          "QIN LUNG CT" = "data/qin_lung_ct",
          "RIDER Lung CT" = "data/rider_lung_ct",
          "C4KC-KiTS" = "data/c4kc_kits",
          "HCC-TACE-Seg" = "data/hcc_tace_seg",
          "Lung-Fused-CT-Pathology" = "data/lung_fused_ct_pathology"
          )
      )),
      column(1, h5("|"), class = "text-center", style = "padding-top: 15px;"),
      column(2, 
      selectInput(
        "demo_dt_patient", "Choose a patient", choices = c(
          "Patient 1" = "patient1.nii.gz",
          "Patient 2" = "patient2.nii.gz",
          "Patient 3" = "patient3.nii.gz",
          "Patient 4" = "patient4.nii.gz",
          "Patient 5" = "patient5.nii.gz",
          "Patient 6" = "patient6.nii.gz",
          "Patient 7" = "patient7.nii.gz",
          "Patient 8" = "patient8.nii.gz",
          "Patient 9" = "patient9.nii.gz",
          "Patient 10" = "patient10.nii.gz"
          ))
      # textInput(inputId = "demo_dt_patient", label="Choose a patient", value='patient1'),
      ),
      column(1, h5("Or"), class = "text-center", style = "padding-top: 15px;"),
      column(3, fileInput("your_dt", "Upload a CT image in '.nii.gz' format")),
      column(1, h2("|"), class = "text-center", style = "margin-top: -5px; "),
      column(2, shinyWidgets::switchInput("interactive", "Interactive", onStatus = "success"), style = "padding-top: 25px;")),
    uiOutput("raster_panel")
  ),
  tabPanel(
    "About",
    includeMarkdown("about.md")
  )
)

server <- function(input, output, session) {
  options(shiny.maxRequestSize = 500*1024^2)
  
  app_dt <- reactive({
    if (is.null(input$your_dt)) {
      path <- file.path(path1 = input$demo_dt, path2 = input$demo_dt_patient)
      out <- read_img_as_array(path)
    } else {
      datapath <- input$your_dt$datapath
      if (tools::file_ext(datapath) == "gz") {
        datapath <- sub("gz$", "nii.gz", datapath)
        file.rename(input$your_dt$datapath, datapath)
      }
      out <- read_img_as_array(datapath)
    }
    return(out)
  })
  
  output$raster_panel <- renderUI({
    if (input$interactive) {
      callModule(raster3d_interactive_Module, "mri_3d", im = app_dt)
      raster3d_interactive_UI("mri_3d")
    } else {
      callModule(raster3d_animation_Module, "mri_3d", im = app_dt)
      raster3d_animation_UI("mri_3d")
    }
  })
  
}

shinyApp(ui, server)

