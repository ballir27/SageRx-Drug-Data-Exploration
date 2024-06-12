library(shiny)
library(shinyWidgets)
library(tidyverse)
library(DT)

orange_book_raw <- read_csv("data/orange_book_products.csv")
fda_ndc_product_raw <- read_csv("data/fda_ndc_product.csv")

fda_ndc_product_edit <- fda_ndc_product_raw |> 
  mutate(appl_no = str_sub(applicationnumber,4)) |> 
  select(appl_no, pharm_classes)

orange_book_raw <- orange_book_raw |> 
  mutate(approval_year = as.numeric(str_sub(approval_date,-4,-1))) |> 
  distinct()

orange_book_raw$appl_type <- orange_book_raw$appl_type |> 
  str_replace_all(c("A"= "AN", "N" = "NDA"))

orange_book_raw <- orange_book_raw |> 
  separate_wider_delim(df_route,";",names = c("drug_form", "application_method"))

orange_book_raw$drug_form <- word(orange_book_raw$drug_form,1,sep = "\\,") |> 
  str_replace_all(c("PELLETS" = "PELLET", "GRANULES" = "GRANULE", "/DROPS" = "", "/SHAMPOO" = "", " FOR SLUSH" = "", "AEROSOL" = "AEROSOL/FOAM"))
orange_book_raw$application_method <- word(orange_book_raw$application_method,1,sep = "\\,") |> 
  str_replace_all(c("ORAL-20" = "ORAL", "ORAL-21" = "ORAL", "ORAL-28" = "ORAL"))

#Merge orangebook and fda_ndc here
orangebook_ndc_merged <- left_join(orange_book_raw,fda_ndc_product_edit, by="appl_no" )

#create drug types list
drug_types <- orangebook_ndc_merged |> 
  pull(type) |> 
  unique() |>  
  sort()

#No longer needed due to pickerInput
#drug_types <- c("All", drug_types)

#create application types list
appl_types <- orangebook_ndc_merged |>
  pull(appl_type) |> 
  unique() |>  
  sort()

appl_types <- c("Both", appl_types)

#create drug forms list
drug_forms <- orangebook_ndc_merged |>
  pull(drug_form) |> 
  unique() |>  
  sort()

drug_forms <- c("All", drug_forms)

#create application method list
application_methods <- orangebook_ndc_merged |>
  pull(application_method) |>
  unique() |>
  sort()

application_methods <- c("All", application_methods)

#create ingredients list
ingredients <- orangebook_ndc_merged |>
  pull(ingredient) |>
  unique() |>
  sort()

ingredients <- c("All", ingredients)

#color pallette
MyPalette <- c(ANDA = "steelblue1", NDA = "firebrick1")