###step3 classfication
seqence=read.table("SV_pos_extract.fa",header = F, sep="\t", quote = "", stringsAsFactors = FALSE, check.names = FALSE)
line=seq(from=1,to=5880,by=2)
seqence2=seqence[-line,]
line2=seq(from=1,to=2940,by=2)
line_data2=c()

for (i in 1:length(line2)){
  bk1=line2[i]
  bk2=bk1+1
  bk1_seq=tolower(unlist(strsplit(seqence2[bk1],split="")))
  box_bk1_seq=paste0(bk1_seq[20:25],collapse="")
  bk2_seq=tolower(unlist(strsplit(seqence2[bk2],split="")))
  box_bk2_seq=paste0(bk2_seq[20:25],collapse="")
  if (box_bk1_seq==box_bk2_seq){
    line_data2=c(line_data2,bk1)
  }
  
}
line_data2=unique(line_data2)

####NHEJ(which <5bp)
line_data_1=c()
for (i in 1:4){
  for (j in 1:length(line2)){
    bk1=line2[j]
    bk2=bk1+1
    bk1_seq=tolower(unlist(strsplit(seqence2[bk1],split="")))
    box_bk1_seq=bk1_seq[(25-i+1):25]
    bk2_seq=tolower(unlist(strsplit(seqence2[bk2],split="")))
    box_bk2_seq=bk2_seq[(25-i+1):25]
    p=length(which(box_bk1_seq==box_bk2_seq))/i
    if ((p>=0.8)&(box_bk1_seq[length(box_bk1_seq)]==box_bk2_seq[length(box_bk1_seq)])){
      line_data_1=c(line_data_1,bk1) 
    }
  }
}
line_data_1=unique(line_data_1)

fun3 <- function(x){
  as.numeric(str_split(x[1],"-")[[1]][2])
}
fun4 <- function(x){
  as.numeric(str_split(x[2],"-")[[1]][2])+1
}
fun5 <- function(x){
  str_split(x[1],":")[[1]][1]
}
NHEJ=matrix(ncol=8,nrow = 322)
NHEJ[,3]=seqence2[line_data_1]
NHEJ[,4]=seqence2[(line_data_1+1)]
line=((line_data_1*2)-1)
NHEJ[,1]=seqence[line,1]
line_2=(line+2)
NHEJ[,2]=seqence[line_2,1]
bk1=apply(NHEJ, 1, fun3)
bk2=apply(NHEJ, 1, fun4)
chr=apply(NHEJ, 1, fun5)
chr=gsub('>', '', chr)
NHEJ[,5] <-chr
NHEJ[,6] <-bk1
NHEJ[,7] <-bk2
NHEJ[,8] <- "NHEJ"

####MMEJ(which 5bp--25bp)
line_data_2=c()
for (i in 5:25){
  for (j in 1:length(line2)){
    bk1=line2[j]
    bk2=bk1+1
    bk1_seq=tolower(unlist(strsplit(seqence2[bk1],split="")))
    box_bk1_seq=bk1_seq[(25-i+1):25]
    bk2_seq=tolower(unlist(strsplit(seqence2[bk2],split="")))
    box_bk2_seq=bk2_seq[(25-i+1):25]
    p=length(which(box_bk1_seq==box_bk2_seq))/i
    if ((p>=0.8)&(box_bk1_seq[length(box_bk1_seq)]==box_bk2_seq[length(box_bk1_seq)])){
      line_data_2=c(line_data_2,bk1) 
        }
    }
}
line_data_2=unique(line_data_2)
MMEJ=matrix(ncol=8,nrow = 34)
MMEJ[,3]=seqence2[line_data_2]
MMEJ[,4]=seqence2[(line_data_2+1)]
line=((line_data_2*2)-1)
MMEJ[,1]=seqence[line,1]
line_2=(line+2)
MMEJ[,2]=seqence[line_2,1]
bk1=apply(MMEJ, 1, fun3)
bk2=apply(MMEJ, 1, fun4)
chr=apply(MMEJ, 1, fun5)
chr=gsub('>', '', chr)
MMEJ[,5] <-chr
MMEJ[,6] <-bk1
MMEJ[,7] <-bk2
MMEJ[,8] <- "MMEJ"

####SSA(which 25bp)
line_data_3=c()
i=25
  for (j in 1:length(line2)){
    bk1=line2[j]
    bk2=bk1+1
    bk1_seq=tolower(unlist(strsplit(seqence2[bk1],split="")))
    box_bk1_seq=bk1_seq[(25-i+1):25]
    bk2_seq=tolower(unlist(strsplit(seqence2[bk2],split="")))
    box_bk2_seq=bk2_seq[(25-i+1):25]
    p=length(which(box_bk1_seq==box_bk2_seq))/i
    if ((p>=0.8)&(box_bk1_seq[length(box_bk1_seq)]==box_bk2_seq[length(box_bk1_seq)])){
      line_data_3=c(line_data_3,bk1) 
    }
  }

line_data_3=unique(line_data_3)
SSA=matrix(ncol=8,nrow = 2)
SSA[,3]=seqence2[line_data_3]
SSA[,4]=seqence2[(line_data_3+1)]
line=((line_data_3*2)-1)
SSA[,1]=seqence[line,1]
line_2=(line+2)
SSA[,2]=seqence[line_2,1]
bk1=apply(SSA, 1, fun3)
bk2=apply(SSA, 1, fun4)
chr=apply(SSA, 1, fun5)
chr=gsub('>', '', chr)
SSA[,5] <-chr
SSA[,6] <-bk1
SSA[,7] <-bk2
SSA[,8] <- "SSA"

result_deletion_classfication=rbind(NHEJ,MMEJ)
result_deletion_classfication=rbind(result_deletion_classfication,SSA)
result_deletion_classfication =result_deletion_classfication[,c(5:8,1:4)]
