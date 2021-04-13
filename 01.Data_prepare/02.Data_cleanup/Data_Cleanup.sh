fq1=$1
fq2=$2
RGID=$3
library=$4
sample=$5
outdir=$6
reference=/home/WGS/reference/ucsc.mm10.fa

outdir=${outdir}/${sample}
workspace=""
fq_file_name=`basename $fq1` 
fq_file_name=${fq_file_name%%.*}

#output diretory
if [ ! -d ${outdir}/cleanfq ]
then mkdir -p ${outdir}/cleanfq
fi

if [ ! -d ${outdir}/bwa ]
then mkdir -p ${outdir}/bwa
fi

if [ ! -d ${outdir}/gatk ]
then mkdir -p ${outdir}/gatk
fi


${SINGULARITY_EXEC}"bwa mem -t 6 -R '@RG\tID:$RGID\tPL:illumina\tLB:$library\tSM:$sample' ${reference} $fq1 $fq2 "| ${SINGULARITY_EXEC}"samtools view -S -b - >${outdir}/bwa/${sample}.bam " && echo "** ${sample}.BWA MEM done **" 
	
${SINGULARITY_EXEC}"samtools sort -@ 4 -m 4G -O bam -o ${outdir}/bwa/${sample}.sorted.bam ${outdir}/bwa/${sample}.bam" && echo "** ${sample}.sorted raw bamfile done ** "


${SINGULARITY_EXEC}"java -jar /home/picard/picard.jar MarkDuplicates \
	INPUT=${outdir}/bwa/${sample}.sorted.bam \
 	METRICS_FILE=${outdir}/bwa/${sample}.markdup_metrics.text \
 	OUTPUT=${outdir}/bwa/${sample}.sorted.markdup.bam \
	CREATE_INDEX=true TMP_DIR=/home/yb77627/data/WGS/tmp " && echo "** ${sample}.sorted.bam MarkDuplicates done **"

${SINGULARITY_EXEC}" samtools index $outdir/bwa/${sample}.sorted.markdup.bam " && echo " ** ${sample}.sorted.markdup.bam index done **"
