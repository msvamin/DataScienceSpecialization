library(datasets)
data(ToothGrowth)
str(ToothGrowth)
summary(ToothGrowth)

library(ggplot2)
ggplot(data=ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_bar(stat="identity",) +
  facet_grid(. ~ supp) +
  xlab("Dose") +
  ylab("Length")
pngFileName = "C:/Amin/Coursera/StatisticalInference/plot2.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()
ggplot(data=ToothGrowth, aes(x=supp, y=len, fill=dose)) +
  geom_bar(stat="identity",) +
  facet_grid(. ~ dose) +
  xlab("Supp") +
  ylab("Length")
pngFileName = "C:/Amin/Coursera/StatisticalInference/plot3.png"
dev.copy(png, pngFileName, width = 480, height = 480, units = "px")
dev.off()