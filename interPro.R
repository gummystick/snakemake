#!/usr/bin/env Rscript
#author: william sies
#date: vrijdag 8 juni 23:06
###########################

#Import of packages
packageList <- c("seqinr", "Biostrings", "stringr", "reshape2", "ggplot2")
# for (i in packageList){
#   print(i)
#   if (i %in% rownames(installed.packages(){
#     install.packages(i)
#   } else {
#     library(i)
#   }
# }
library(seqinr)
library(Biostrings)
library(stringr)
library(reshape2)
library(ggplot2)

#For commandline parameter usage
args = commandArgs(trailingOnly = TRUE)
if (length(args)==0){
  stop("Please provide inputfile as arg", call.=FALSE)
} else if (length(args)>3){
  stop("To many input args provided", call.=FALSE)
}

#import gene and protein info
frame <- read.csv(args[1])
frame2 <- read.csv(args[2], header = FALSE)

#Gather information and calculate GC content
gcContent <- c()
totalContent <- c()
genes <- c()
for (gene in frame2$V1){
  print(paste(gene, frame2$V3[frame2$V1 == gene], unique(frame$begin[frame$geneId == gene]), unique(frame$eind[frame$geneId == gene]), unique(frame$eind[frame$geneId == gene])-unique(frame$begin[frame$geneId == gene])))
  totalContent <- c(totalContent, unique(frame$eind[frame$geneId == gene])[1]-unique(frame$begin[frame$geneId == gene])[1])
  genes <- c(genes, gene)
  fasta <- read.fasta(paste(trimws(frame2$V3[frame2$V1 == gene]),".fasta", sep=""), seqtype = "DNA", as.string = TRUE)
  subSeq <- tryCatch(subseq(fasta[[1]][1], start=unique(frame$begin[frame$geneId == gene])[1], end=unique(frame$eind[frame$geneId == gene])[1]), error = function(e){
    print("ERROR")
  })
  if (subSeq != "ERROR"){
    gcContent <-  c(gcContent, str_count(subSeq, "g")+str_count(subSeq, "c"))
  } else {
    gcContent <- c(gcContent, 0)
  }
  print(genes)
  print(totalContent)
  print(gcContent)
}

#Calculate GC pergentage and make data frame
df <- data.frame(gene=genes, GC=gcContent/totalContent*100)
df[is.na(df)] <- 0

#Plot GC
pdf(args[3])
  p <- ggplot(data=df, aes(x=gene, y=GC)) +
    geom_bar(stat="identity")
  p + coord_flip()
dev.off()
