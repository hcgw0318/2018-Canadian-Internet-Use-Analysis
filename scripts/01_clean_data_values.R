library(janitor)
library(tidyverse)
library(here)

raw_data <- read_csv(here("inputs/data/raw_data.csv"))[,c(2:425)] %>%
  mutate(AGE_GRP = as.numeric(AGE_GRP))
labels_raw <- read_file(here("inputs/data/response_labels.txt"))

labels_raw_tibble <- as_tibble(str_split(labels_raw, "\"\r\n")[[1]]) %>% 
  mutate(value = str_remove(value, "label define   ")) %>%
  mutate(value = str_remove(value, "_FMT")) %>%
  mutate(value = str_remove_all(value, " ///")) %>%
  mutate(value = str_replace(value, "[ ]{2,}", "XXX")) %>% 
  mutate(splits = str_split(value, "XXX")) %>% 
  rowwise() %>% 
  mutate(variable_name = splits[1], cases = splits[2]) %>% 
  mutate(cases = str_replace_all(cases, "\n [ ]{2,}", "")) %>%
  select(variable_name, cases) %>% 
  drop_na()

labels_raw_tibble <- labels_raw_tibble %>% 
  mutate(splits = str_split(cases, "[ ]{0,}\"[ ]{0,}"))

add_cw_text <- function(x, y){
  if(!is.na(as.numeric(x))){
    x_new <- paste0(y, "==", x,"~")
  }
  else{
    x_new <- paste0("\"",x,"\",")
  }
  return(x_new)
}

cw_statements <- labels_raw_tibble %>% 
  rowwise() %>% 
  mutate(splits_with_cw_text = list(modify(splits, add_cw_text, y = variable_name))) %>% 
  mutate(cw_statement = paste(splits_with_cw_text, collapse = "")) %>% 
  mutate(cw_statement = paste0("case_when(", cw_statement,"TRUE~\"NA\")")) %>% 
  mutate(cw_statement = str_replace(cw_statement, ",\"\",",",")) %>% 
  select(variable_name, cw_statement)

cw_statements <- 
  cw_statements %>% 
  mutate(variable_name = str_remove_all(variable_name, "\r")) %>%
  mutate(variable_name = str_remove_all(variable_name, "\n")) %>%
  mutate(cw_statement = str_remove_all(cw_statement, "\r")) %>%
  mutate(cw_statement = str_remove_all(cw_statement, "\n"))


cius_data <- raw_data %>%
  mutate(across(everything(), ~ eval(parse(text = cw_statements %>%
                                             filter(variable_name==deparse(substitute(.x))) %>%
                                             select(cw_statement) %>%
                                             pull()))))

write_csv(cius_data, here("outputs/data/cleaned_data_v1.csv"))
