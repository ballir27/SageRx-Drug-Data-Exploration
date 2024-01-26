library(shiny)
library(tidyverse)
library(DT)

orange_book_raw <- read_csv("data/orange_book_products.csv")
fda_ndc_product_raw <- read_csv("data/fda_ndc_product.csv")

fda_ndc_product_edit <- fda_ndc_product_raw |> 
  mutate(appl_no = str_sub(applicationnumber,4)) |> 
  select(appl_no, active_numerator_strength, active_ingred_unit, pharm_classes)

orange_book_raw <- orange_book_raw |> 
  mutate(approval_year = as.numeric(str_sub(approval_date,-4,-1)))

orange_book_raw$appl_type <- orange_book_raw$appl_type |> 
  str_replace_all(c("A"= "AN", "N" = "NDA"))

orange_book_raw <- orange_book_raw |> 
  separate_wider_delim(df_route,";",names = c("drug_form", "application_method"))

#Merge orangebook and fda_ndc here
orangebook_ndc_merged <- left_join(orange_book_raw,fda_ndc_product_edit, by="appl_no" )

drug_types <- orangebook_ndc_merged |> 
  pull(type) |> 
  unique() |>  
  sort()

drug_types <- c("All", drug_types)

appl_types <- orangebook_ndc_merged |>
  pull(appl_type) |> 
  unique() |>  
  sort()

appl_types <- c("Both", appl_types)