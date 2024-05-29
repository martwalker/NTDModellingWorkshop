###########################################################
## Opening the black box of an NTD mathematical model
## Martin Walker & Aditya Ramani
##########################################################
rm(list=ls())

###########################################################
## Installing and loading R packages
##########################################################
#install.packages("deSolve")
library(deSolve)

###########################################################
## Load R scripts
##########################################################
source("funcs.R")
source("par.R")

###########################################################
## run model with default parameters to equilibrium
##########################################################
equib_R02 <- runmod(init=1, par=par)

###########################################################
## plot outputs
##########################################################
#pdf(file="equib_R02.pdf", width=8, height=8)
par(mfrow=c(2,2))
plot(W~time, data=equib_R02, ylab="Mean number schistosomes per host", xlab="Years", type="l", lwd=2)
plot(E~time, data=equib_R02, ylab="Mean egg output per host", xlab="Years", type="l", lwd=2)
plot(p~time, data=equib_R02, ylab="Prevalence", xlab="Years", ylim=c(0,100), type="l", lwd=2)
plot(Re~time, data=equib_R02, ylab="Effective reproduction number", xlab="Years", type="l", lwd=2)
#dev.off()

###########################################################
## change parameter value
##########################################################
par["R0"] <- 3

###########################################################
## re-run model with R0=3 to equilibrium
##########################################################
equib_R03 <- runmod(init=1, par=par)

###########################################################
## simulating 5 years of annual mass drug administration
##########################################################
par["dotx"] <- 1
par["start.tx"] <- 1
par["stop.t"] <- 11
par["freq.tx"] <- 1
par["n.tx"] <- 5
par["R0"] <- 2

interv_an <- runmod(init = equib_R02[nrow(equib_R02),"W"], par)

###########################################################
## simulating 5 years of bi-annual mass drug administration
##########################################################
par["dotx"] <- 1
par["start.tx"] <- 1
par["stop.t"] <- 11
par["freq.tx"] <- 0.5
par["n.tx"] <- 10
par["R0"] <- 2

interv_bi <- runmod(init = equib_R02[nrow(equib_R02),"W"], par)

###########################################################
## plot annual and biannual MDA dynamics
##########################################################
#pdf(file="interv_R02.pdf", width=8, height=8)
par(mfrow=c(2,2))
plot(W~time, data=interv_bi, ylab="Mean number schistosomes per host", xlab="Years", type="l", lwd=2)
lines(W~time, data=interv_an, lwd=2, lty="dashed")
plot(E~time, data=interv_bi, ylab="Mean egg output per host", xlab="Years", type="l", lwd=2)
lines(E~time, data=interv_an, lwd=2, lty="dashed")
plot(p~time, ylab="Prevalence", data=interv_bi, type="l",xlab="Years", lwd=2, ylim=c(0,100))
lines(p~time, data=interv_an, lwd=2, lty="dashed")
plot(Re~time, data=interv_bi, ylab="Effective reproduction number", xlab="Years", type="l", lwd=2)
lines(Re~time, data=interv_an, lwd=2, lty="dashed")
#dev.off()
