###step1 extract pos
file_raw=read.table("SV_raw_data.txt",header = F, sep="\t", quote = "", stringsAsFactors = FALSE, check.names = FALSE)
name= c("Brca1_10.5E","Brca1_16.5E","Brca1_1M","Brca1_4M","Brca1_8M","Brca1_12M")
file_raw=file_raw[(which(file_raw[,1] %in% name3)),]
file_raw=file_raw[which(file_raw[,8]=="DEL"),]
file=unique(file_raw[,2:5])

result=c()
for (i in 1:(length(file[,1]))){
data=matrix(nrow = 2,ncol = 3)
chr=file[i,1]
BP1_pos1=as.numeric(file[i,2])-25
BP1_pos2=as.numeric(file[i,2])
BP2_pos1=as.numeric(file[i,4])-25-1
BP2_pos2=as.numeric(file[i,4])-1
data[,1]<- chr
data[1,2]<- BP1_pos1
data[1,3]<- BP1_pos2
data[2,2]<- BP2_pos1
data[2,3]<- BP2_pos2
result=rbind(result,data)
}
write.table(result,"SV_pos_extract.txt",col.names=F,row.names=F,quote=F,sep="\t")
