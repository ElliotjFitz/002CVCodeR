# myRigraphvis.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myRigraphplotterinv.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
##########################Find max value to normalise with######
maxnodevals <- 2:100;

for(t in 2:100){

mypathmax <- file.path("G:","sampleScripts","New Folder","WBCinv",paste("WNBsinvdata_",t,".txt", sep = ""))


WBCtmp <- read.table(mypathmax,header=TRUE)

maxnodevals[t] <- max(WBCtmp, na.rm=TRUE)
}
#chose 20 so the betweeness values are between 0 and 20 for apping purposes. Feel free for your own scale.
normval <- max(maxnodevals,na.rm=TRUE)/20
print(normval)
###############################################################

##########################Find max value to normalise EBC with######
maxebvals <- 2:299;

for(p in 2:299){

mypathebmax <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_",p,".txt", sep = ""))


WEBtmp <- read.table(mypathebmax,header=TRUE)

maxebvals[p] <- max(WEBtmp, na.rm=TRUE)
}
#chose 10 so the betweeness values are between 0 and 10 for apping purposes. Feel free for your own scale.
normebval <- max(maxebvals,na.rm=TRUE)/10
###############################################################



for(i in 2:100){

# load in the textdata.  

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", i, ".txt", sep = ""))

psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)
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
mypathWBC <- file.path("G:","sampleScripts","New Folder","WBCinv",paste("WNBsinvdata_",i,".txt", sep = ""))
nb <- read.table(mypathWBC,header=TRUE)
WBCvals <- as.matrix(nb)

#edge betweeness
mypathWEB <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_",i,".txt", sep = ""))
eb <- read.table(mypathWEB,header=TRUE)
WEBvals <- as.matrix(nb)



#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

#png("F:/sampleScripts/New Folder/Testsave143.png")
mypathsave <- file.path("G:","sampleScripts","New Folder",paste("WBCinvplot_", i, ".png", sep = ""))


png(file=mypathsave)

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=(WBCvals[,2])/normval,
edge.width=(WEBvals)/normebval,vertex.label=NA)

#map(edge.betweenness(g,weights=wts), c(1,10))
dev.off()
}





# plot the network using betweenness values
#w <- nb #(ebw+1)/(mean(ebw+1)) # translate to avoid zero weights
#dev.new();
#plot(g,layout=as.matrix(psn[,1:2]),vertex.size=5,vertex.label=NA,vertex.color=w;

#plot(g,layout=as.matrix(psn[,2:3]),vertex.size=0.01,vertex.label=NA,edge.color="magenta",edge.width=w);

