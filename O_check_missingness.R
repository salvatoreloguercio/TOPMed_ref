
#! /usr/bin/Rscript

options(stringsAsFactors = F)


filelist = list.files(pattern="*.smiss$")

smiss_summaries<-do.call("rbind",lapply(filelist,function(x) summary(read.delim(x,header=T)$MISSING_CT)))

rownames(smiss_summaries)<-gsub(".smiss","",filelist)

write.table(smiss_summaries,sep="\t",row.names=T,quote=F,file="O_missingness_summaries.tsv")
