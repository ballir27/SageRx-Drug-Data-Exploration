library(shiny)
library(tidyverse)
library(DT)

orange_book_raw <- read_csv("data/orange_book_products.csv")

orange_book_raw <- orange_book_raw |> 
  mutate(approval_year = as.numeric(str_sub(approval_date,-4,-1)))

drug_types <- orange_book_raw |> 
  pull(type) |> 
  unique() |>  
  sort()

drug_types <- c("All", drug_types)

appl_types <- orange_book_raw |> 
  pull(appl_type) |> 
  unique() |>  
  sort()

appl_types <- c("Both", appl_types)