library(tidyverse)
library(readxl)
library(janitor)

x_2019 <- read_xlsx("class_enrollment_summary_by_term_2.26.19.xlsx", skip = 3) %>% 
  clean_names() %>% 
  filter(! is.na(course_name)) %>% 
  select(course_id, course_title, course_name, u_grad)

y_2018 <- read_xlsx("class_enrollment_summary_by_term_03.06.18.xlsx", skip = 3) %>% 
  clean_names() %>% 
  filter(! is.na(course_name)) %>% 
  select(course_id, course_title, course_name, u_grad)

z_joined <- inner_join(x_2019, y_2018, by = "course_id") %>% 
  select(course_title.x, course_name.x, u_grad.y, u_grad.x) %>% 
  mutate(change = u_grad.x - u_grad.y) %>% 
  arrange(change) %>% 
  slice(1:10)
  

