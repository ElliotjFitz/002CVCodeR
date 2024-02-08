#top20plotterflt

# myRigraphvis.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("topnodesplotterflt.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")
##########################Find max value to normalise with######
maxnodevals <- 2:299;

for(t in 2:299){

mypathmax <- file.path("G:","sampleScripts","New Folder","EPLweights","filteredwts",paste("02Dilfilteredwts", t, sep = ""))


WBCtmp <- read.table(mypathmax,header=TRUE)

maxnodevals[t] <- max(WBCtmp, na.rm=TRUE)
}
#chose 20 so the betweeness values are between 0 and 3 for mapping purposes. Feel free for your own scale.
normval <- max(maxnodevals,na.rm=TRUE)/10
print(normval)
###############################################################
for(i in 73:115){

# load in the textdata.  

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights","filteredwts",paste("02Dilfilteredwts", i, sep = ""))



psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)
# we will build a weighted network, with weights being magnitude of contact force

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#read in top 20 nodes
top20nodesraw<-read.csv(paste("G:/sampleScripts/New Folder/filtered/filtered top/Top20fltnodedata_",i,".csv",sep=""),header=TRUE)
top20nodes <-top20nodesraw[,2]

#read in top 10
top10nodesraw<-read.csv(paste("G:/sampleScripts/New Folder/filtered/filtered top/Top10fltnodedata_",i,".csv",sep=""),header=TRUE)
top10nodes <-top10nodesraw[,2]


# node betweenness
mypathWBC <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WNBsebdata_",i,".txt", sep = ""))
nb <- read.table(mypathWBC,header=TRUE)
WBCvals <- as.matrix(nb)


#colour the nodes

V(g)$colour <-"chartreuse2"
V(g)[top20nodes]$colour<-"purple"
V(g)[top10nodes]$colour<-"coral1"



#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge filtered\WNB filtered plots

#png("F:/sampleScripts/New Folder/Testsave143.png")
mypathsave <- file.path("G:","sampleScripts","New Folder","filtered","WNB filtered plots",paste("WNBflt colour plots_", i, ".png", sep = ""))


png(file=mypathsave)

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=2.5+((WBCvals[,2])/normval),
vertex.color=V(g)$colour,
edge.width=0.1,vertex.label=NA)

#map(edge.betweenness(g,weights=wts), c(1,10))
dev.off()
}
