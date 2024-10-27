library(ggplot2)

rairuoho<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt',header=T, sep="\t", dec='.')
library("dplyr")
library("tidyr")


rairuoho1 <- dplyr::select(rairuoho, -row, -column)
rairuoho1$treatment<-ifelse(rairuoho1$treatment=='nutrient', 'enriched', 'water')
rairuoho2 <- rairuoho1 %>%
  pivot_longer(day3:day8, names_to='day', values_to='length')
rairuoho3 <- rairuoho2 %>%
  unite('Spatial', spatial1:spatial2, sep = '_')

