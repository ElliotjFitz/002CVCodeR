# myRigraphvis.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraphvis.R")
#
# Author: David M. Walker 27/11/2014
# Edited: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
##########################Find max value to normalise with######
maxvals <- 1:298;

for(t in 1:298){

mypathmax <- file.path("G:","sampleScripts","New Folder","WBC2data",paste("WBC2data_",t,".txt", sep = ""))


WBCtmp <- read.table(mypathmax,header=TRUE)

maxvals[t] <- max(WBCtmp, na.rm=TRUE)
}
#chose 20 so the betweeness values are between 0 and 20 for apping purposes. Feel free for your own scale.
normval <- max(maxvals,na.rm=TRUE)/20
###############################################################


for(i in 1:5){

# load in the textdata.  

psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(paste("p02wts",i,".txt",sep=""))

# we will build a weighted network, with weights being magnitude of contact force

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


# plot the network
#dev.new();
#plot(g,layout=as.matrix(psn[,1:2]),vertex.size=0.01,vertex.label=NA,edge.width=map(wts/mean(wts),c(1,7)),edge.color="steelblue")

# calculate weighted netork edge betweenness
#ebw <- edge.betweenness(g,weights=wts)


# node betweenness
mypathWBC <- file.path("G:","sampleScripts","New Folder","WBC2data",paste("WBC2data_",i,".txt", sep = ""))
nb <- read.table(mypathWBC,header=TRUE)
WBCvals <- as.matrix(nb)

#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

#png("F:/sampleScripts/New Folder/Testsave143.png")
mypathsave <- file.path("G:","sampleScripts","New Folder",paste("WBC2plotcomp_", i, ".png", sep = ""))

png(file=mypathsave)

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=(WBCvals[,2])/normval,
edge.width=map(wts/mean(wts),c(1,7)),vertex.label=NA)

#map(edge.betweenness(g,weights=wts), c(1,10))
dev.off()
}





# plot the network using betweenness values
#w <- nb #(ebw+1)/(mean(ebw+1)) # translate to avoid zero weights
#dev.new();
#plot(g,layout=as.matrix(psn[,1:2]),vertex.size=5,vertex.label=NA,vertex.color=w;

#plot(g,layout=as.matrix(psn[,2:3]),vertex.size=0.01,vertex.label=NA,edge.color="magenta",edge.width=w);

