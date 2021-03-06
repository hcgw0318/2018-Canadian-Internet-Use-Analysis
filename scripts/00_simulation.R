library(tidyverse)

set.seed(318)
population <- 13810
sim_dataset <- tibble(age_group = sample(x = c(1:6),
                                         size = population,
                                         replace = TRUE),
                      gender = sample(x = c(1:2),
                                      size = population,
                                      replace = TRUE),
                      education = sample(x = c(1:3),
                                      size = population,
                                      replace = TRUE))

sim_dataset <- sim_dataset %>% 
  mutate(age_group=case_when(age_group==1~"15 to 24 years",
                             age_group==2~"25 to 34 years",
                             age_group==3~"35 to 44 years",
                             age_group==4~"45 to 54 years",
                             age_group==5~"55 to 64 years",
                             age_group==6~"65 years and over",),
         gender=case_when(gender==1~'Male',
                          gender==2~'Female'),
         education=case_when(education==1~"High school diploma or an equivalency certificate or less",
                             education==2~"Certificate/diploma Univ. below bachelor/College/CEGEP/trade",
                             education==3~"University degree above the bachelor or bachelor's degree"))

ggplot(sim_dataset, aes(x=gender, fill=age_group)) + geom_bar(stat = 'count')
ggplot(sim_dataset, aes(x=gender, fill=education)) + geom_bar(stat = 'count')

