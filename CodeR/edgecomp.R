#source("edgecomp.R")
#Author: Elliot Fitzgerald
#find commonality between mincut edges and top edge betweenness ids
library("igraph")
steps <- 1:298
topsize <- 1:298
cutsize <- 1:298

cut20edgeolap <- 1:298
top20edgeolap <- 1:298



for(i in steps){
 

#build the graph for finding edge ids
weightpath <- file.path("G:","sampleScripts","New Folder","EPLweights",paste("EPLweights", i+1, ".txt", sep = ""))

psn <- read.table(paste("psn_",i+1,".txt",sep=""))
cts <- read.table(weightpath)

g <- graph.edgelist(as.matrix(cts[,1:2]),directed=FALSE)



#load in top edges
topedgeraw <- read.table(paste("G:/sampleScripts/New Folder/edgestopnodes/top20nodesnedgess",i+1,".txt",sep=""))
topedge<- 1:length(topedgeraw[,1])
for(t in topedge){
topedge[t] <- get.edge.ids(g,topedgeraw[t,])
}

topsize[i]<-length(topedge)



#load in the cut node ids again
cutnodes <-read.table(paste("G:/cutset/cutset",i,sep=""))
edgecutsvert<- 1:length(cutnodes[,1])

#get the edge ids from the nodes
for(w in edgecutsvert){
edgecutsvert[w] <- get.edge.ids(g,cutnodes[w,])
}

#get edge ids for the horizontal cut too
cutlist<-read.table(paste("G:/sampleScripts/lat-cut-elliot/for-elliot/cutset-lat",i,sep=""))

cutlatnodescol1<-as.numeric(gsub("\\D","",cutlist[,1]))
cutlatnodescol2<-as.numeric(gsub("\\D","",cutlist[,2]))

edgecutslat<- 1:length(cutlatnodescol1)


for(p in edgecutslat){
edgecutslat[p] <- get.edge.ids(g,c(cutlatnodescol1[p],cutlatnodescol2[p]))
}

edgecuts<-unique(c(edgecutslat,edgecutsvert))

cutsize[i] <- length(edgecuts)

###############################################################
olap20<-intersect(unique(edgecuts),unique(topedge))

cut20edgeolap[i]<-100*(length(olap20)/length(unique(edgecuts)))

top20edgeolap[i]<-100*(length(olap20)/length(unique(topedge)))
###############################################################
}





mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_olap_over_cut_edges", ".png", sep = ""))


png(file=mypathsave)

plot(2:299,cut20edgeolap,xlab="strain interval",ylab="common edges/(cut-edges)[%]", col="magenta" )

dev.off()


mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_olap_over_top20_edges", ".png", sep = ""))


png(file=mypathsave)

plot(2:299,top20edgeolap,xlab="strain interval",ylab="common edges/(HH edges)[%]", col="blue" )

dev.off()



mypathsave <- file.path("G:","sampleScripts","New Folder",paste("no_of_HH_edges", ".png", sep = ""))


png(file=mypathsave)

plot(topsize,xlab="strain interval",ylab="HH edges", col="purple1" )

dev.off()



