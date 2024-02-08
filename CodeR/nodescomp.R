#source("nodescomp.R")
#find commonality between nodes of min cut and nodes of high BC
# Elliot Fitzgerald Author. 


steps <- 1:298
cut20olap <- 1:298
top20olap <- 1:298
cut10olap <- 1:298
top10olap <- 1:298
cnodes    <- 1:298


for(i in steps){

#read in top 20 nodes
top20nodesraw<-read.table(paste("G:/sampleScripts/New Folder/Top20nodes/Top20nodedata_",i+1,".txt",sep=""),header=TRUE)
top20nodes <-top20nodesraw[,2]

#read in top 10 nodes
top10nodesraw<-read.table(paste("G:/sampleScripts/New Folder/Top20nodes/Top10nodedata_",i+1,".txt",sep=""),header=TRUE)
top10nodes <-top10nodesraw[,2]

#nodes of the cutset
################################################################
cutnodesraw<-read.table(paste("G:/cutset/cutset",i,sep=""))
cutnodesvert <- unique(c(cutnodesraw[,1],cutnodesraw[,2]))
#################################################################


#nodes of lateral cutset
##################################################################

cutlist<-read.table(paste("G:/sampleScripts/lat-cut-elliot/for-elliot/cutset-lat",i,sep=""))

cutlatnodescol1<-as.numeric(gsub("\\D","",cutlist[,1]))
cutlatnodescol2<-as.numeric(gsub("\\D","",cutlist[,2]))

cutlatnodes<- unique(c(cutlatnodescol1,cutlatnodescol2))

#################################################################

cutnodes <- unique(c(cutnodesvert,cutlatnodes))

cnodes[i] <- length(cutnodes)

#top20&cutset overlap
olap20<-intersect(cutnodes,top20nodes)

#same for 10
olap10<-intersect(cutnodes,top10nodes)

cut20olap[i]<-100*(length(olap20)/length(cutnodes))

top20olap[i]<-100*(length(olap20)/length(top20nodes))

cut10olap[i]<-100*(length(olap10)/length(cutnodes))

top10olap[i]<-100*(length(olap10)/length(top10nodes))

}
#plot(cut20olap)
#plot(top20olap)
#plot(cut10olap)
#plot(top10olap)


#mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_nodes_20_over_cut_nodes", ".png", sep = ""))


#png(file=mypathsave)

#plot(2:299,cut20olap,col="purple",xlab="strain interval",ylab="common nodes(top20%&min-cut)/(nodes in min-cut)[%]")

#dev.off()

#mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_nodes_10_over_cut_nodes", ".png", sep = ""))


#png(file=mypathsave)

#plot(2:299,cut10olap,col="brown1",xlab="strain interval",ylab="common nodes(top10%&min-cut)/nodes in min-cut[%]")

#dev.off()

#mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_nodes_over_top20", ".png", sep = ""))


#png(file=mypathsave)

#plot(2:299,top20olap,col="purple",xlab="strain interval",ylab="common nodes(top10%&min-cut)/nodes in top20%[%]")

#dev.off()

#mypathsave <- file.path("G:","sampleScripts","New Folder",paste("plot_nodes_over_top10", ".png", sep = ""))


#png(file=mypathsave)

#plot(2:299,top10olap,col="brown1", xlab="strain interval",ylab="common nodes(top10%&min-cut)/nodes in top10%[%]")

#dev.off()
mypathsave <- file.path("G:","sampleScripts","New Folder",paste("nodesincut", ".png", sep = ""))

png(file=mypathsave)

plot(2:299,cnodes,col="brown1", xlab="strain interval",ylab="Nodes belonging to edges in min-cut")

dev.off()

