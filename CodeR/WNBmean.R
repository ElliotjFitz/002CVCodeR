#source("WNBmean.R")

meannodes <- 2:299;

for(t in 2:299){

mypathmax <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WNBsebdata_",t,".txt", sep = ""))


WBCtmp <- read.table(mypathmax,header=TRUE)

meannodes[t-1] <- mean(WBCtmp[,2], na.rm=TRUE)
}

print(length(meannodes))


mypathsave <- file.path("G:",paste("mean_WNB", ".png", sep = ""))


png(file=mypathsave)

plot(2:299,meannodes,xlab="strain stage", ylab="mean WNB")

dev.off()
