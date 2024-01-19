library(shiny)
library(tidyverse)
library(DT)

orange_book_raw <- read_csv("data/orange_book_products.csv")

drug_types <- orange_book_raw %>% 
  pull(type) %>% 
  unique() %>% 
  sort()

drug_types <- c("All", drug_types)