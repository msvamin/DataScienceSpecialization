set.seed(11)
lambda <- 0.2
nosim <- 1000
n <- 40
meanSamples = matrix(rexp(nosim*n,lambda), nosim)
Means = apply(meanSamples, 1, mean)

hist(Means, breaks=50, prob = TRUE)
lines(density(Means), col="blue", lwd=2)
x <- seq(min(Means),max(Means), length=100)
lines(x,dnorm(x,mean=5, sd=sqrt(0.625)), col="red",lwd=2)
legend("topright", c("simulation","theory"), lty=c(1,1), col=c("blue","red"))

pngFileName = "C:/Amin/Coursera/StatisticalInference/plot1.png"
dev.copy(png, pngFileName, width = 640, height = 480, units = "px")
dev.off()