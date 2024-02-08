# myRigraphvis.R
#
# script to read in contact data and build graph in Rigraph
#
# run in R with:
# source("myplotteredge.R")
#
# Author: Elliot J Fitzgerald
# load in the igraph library
library(igraph)

source("map.R")

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



for(i in 60:115){

# load in the textdata.  

weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", i, ".txt", sep = ""))

psn <- read.table(paste("psn_",i,".txt",sep=""))
cts <- read.table(weightpath)
# we will build a weighted network, with weights being magnitude of contact force

wts <- cts[,3]

# build the graph from the contacts
g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)


#edge betweeness
mypathWEB <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_",i,".txt", sep = ""))
eb <- read.table(mypathWEB,header=TRUE)
WEBvals <- as.matrix(eb)
##############################################################################

#colouring edges

mypathtopedge <- file.path("G:","sampleScripts","New Folder","SEBdata",paste("WEBsebdata_", i,".txt", sep = ""))

valuesraw <- read.table(mypathtop,header=TRUE)



sortvals <- sort(valuesraw[,2], decreasing=TRUE)

cutoff <-floor(0.2*length(sortvals))

E(g)[which(valuesraw[,2] >= sortvals[cutoff])]$colour<-"red"
E(g)[which(valuesraw[,2] <= sortvals[cutoff])]$colour<-"blue"







##############################################################################



#' # Betweenness centrality - number of geodesics (shortest paths) going through a vertex or an edge

#png("F:/sampleScripts/New Folder/Testsave143.png")
mypathsave <- file.path("G:","sampleScripts","New Folder",paste("WBCSEBedge_", i, ".png", sep = ""))


png(file=mypathsave)

plot(g, layout=as.matrix(psn[,1:2]),
vertex.size=0.1,
edge.color=E(g)$colour,
edge.width=(WEBvals)/normebval,vertex.label=NA)

#map(edge.betweenness(g,weights=wts), c(1,10))
dev.off()
}



