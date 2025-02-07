rairuoho<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/rairuoho.txt',header=T, sep="\t", dec='.')
library("ggplot2")
library("dplyr")
library("tidyr")
library("ggthemes")


rairuoho1 <- dplyr::select(rairuoho, -row, -column)
rairuoho1$treatment<-ifelse(rairuoho1$treatment=='nutrient', 'enriched', 'water')

rairuoho1 <- rairuoho1 %>%
  pivot_longer(day3:day8, names_to='day', values_to='length')

rairuoho1 <- rairuoho1 %>% mutate(day = as.integer(str_replace(day, "day", "")))

# Trend of growth length with Number of Days

gg1 <- ggplot(data=rairuoho1,
                aes(x = day, y = length, color = treatment, shape = bed))

plot1 <- gg1 + geom_point() +
  geom_smooth(method = "lm", se = FALSE, linetype = "dashed") +
  labs(title = "Growth length vs. Day",
       x = "Day",
       y = "Growth length") +
  theme_classic()
plot1

ggsave(plot1,filename = "outputs/Plot1.pdf",width = 15,
       height = 15,units = "cm")

# Box plots of final germination number under different treatments

gg2 <- ggplot(data=rairuoho, aes(x = treatment, y = day8, fill = treatment))

plot2 <- gg2 + geom_boxplot() +
  labs(title = "Final germination length vs. Treatment",
                                  x = "Treatment",
                                  y = "Final germination length") +
  theme_economist() + scale_colour_economist()

plot2

ggsave(plot2,filename = "outputs/Plot2.pdf",width = 15,
       height = 15,units = "cm")