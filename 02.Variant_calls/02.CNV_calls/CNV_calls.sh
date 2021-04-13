outdir=$1
sample=$2
reference=/home/WGS/reference/ucsc.mm10.fa
reference_dir=/home/WGS/reference

if [ ! -d ${outdir}/cnvnator ]
then mkdir -p ${outdir}/cnvnator
fi
 ${SINGULARITY_EXEC}"cnvnator -genome mm10 -root ${outdir}/cnvnator/${sample}.root -tree ${outdir}/bwa/${sample}.sorted.markdup.bam" && echo "** ${sample} tree done ** "
 ${SINGULARITY_EXEC}"cnvnator -genome mm10 -root ${outdir}/cnvnator/${sample}.root -his 100 -d ${reference_dir}/ " && echo "** ${sample} his done ** "
 ${SINGULARITY_EXEC}"cnvnator -genome mm10 -root ${outdir}/cnvnator/${sample}.root -stat 100" && echo "** ${sample} stat done ** "
 ${SINGULARITY_EXEC}"cnvnator -genome mm10 -root ${outdir}/cnvnator/${sample}.root -partition 100" && echo "** ${sample} partition done ** "
 ${SINGULARITY_EXEC}"cnvnator -genome mm10 -root ${outdir}/cnvnator/${sample}.root -call 100 > ${outdir}/cnvnator/${sample}.cnvout.100.txt" && echo "** ${sample} call done ** "
 ${SINGULARITY_EXEC}"cnvnator -root ${outdir}/cnvnator/${sample}.root -eval 100" && echo "** bin_size done ** "
