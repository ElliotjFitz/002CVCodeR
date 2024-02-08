#top20plotter

# myRigraphvis.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("topnodesplotter.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
##########################Find max value to normalise with######
maxnodevals <- 2:299;

for(t in 2:299){

mypathmax <- file.path("G:","0.02cv","0.02cv","WNBdata",paste("WNBdata_", i, ".txt", sep = ""))



WBCtmp <- read.table(mypathmax,header=TRUE)

maxnodevals[t] <- max(WBCtmp, na.rm=TRUE)
}
#chose 20 so the betweeness values are between 0 and 3 for mapping purposes. Feel free for your own scale.
normval <- max(maxnodevals,na.rm=TRUE)/3
print(normval)
###############################################################
for(i in 2:299){

# load in the textdata.  
weightpath <- file.path("G:","0.02cv","0.02cv","EPL weights",paste("EPLweightsCV", i, ".txt", sep = ""))
psnpath <- file.path("G:","0.02cv","0.02cv","psn",paste("psn_", i, ".txt", sep = ""))


psn <- read.table(psnpath)
cts <- read.table(weightpath)
# we will build a weighted network, with weights being magnitude of contact force

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#read in top 20 nodes
top20nodesraw<-read.table(paste("G:/0.02cv/0.02cv/Top 20/Top20nodedata_",i,".txt",sep=""),header=TRUE)
top20nodes <-top20nodesraw[,2]

#read in top 10
top10nodesraw<-read.table(paste("G:/0.02cv/0.02cv/Top 10/Top10nodedata_",i,".txt",sep=""),header=TRUE)

top10nodes <-top10nodesraw[,2]


# node betweenness
mypathWBC <- file.path("G:","0.02cv","0.02cv","WNBdata",paste("WNBdata_", i, ".txt", sep = ""))

nb <- read.table(mypathWBC,header=TRUE)
WBCvals <- as.matrix(nb)


#colour the nodes

V(g)$colour <-"chartreuse2"
V(g)[top20nodes]$colour<-"purple"
V(g)[top10nodes]$colour<-"coral1"



#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

#png("F:/sampleScripts/New Folder/Testsave143.png")
mypathsave <- file.path("G:","0.02cv","0.02cv","Plots",paste("WNBCV colour plots_", i, ".png", sep = ""))


png(file=mypathsave)

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=2.5+((WBCvals[,2])/normval),
vertex.color=V(g)$colour,
edge.width=0.1,vertex.label=NA)

#map(edge.betweenness(g,weights=wts), c(1,10))
dev.off()
}
