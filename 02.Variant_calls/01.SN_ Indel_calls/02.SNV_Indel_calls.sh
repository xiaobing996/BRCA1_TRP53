fq1=$1
fq2=$2
RGID=$3
library=$4
sample=$5
outdir=$6
reference=/home/WGS/reference/ucsc.mm10.fa
${SINGULARITY_EXEC}"gatk HaplotypeCaller --emit-ref-confidence GVCF -R $reference -I $outdir/bwa/${sample}.sorted.markdup.bam -O ${outdir}/gatk/${sample}.HC.g.vcf.gz  " && echo "** GVCF ${sample}.HC.g.vcf.gz done **"
${SINGULARITY_EXEC}"gatk VariantFiltration -V ${outdir}/vcf/${sample}.snp.vcf.gz \
-filter \"QD < 2.0\" --filter-name \"QD2\" \
-filter \"SOR > 3.0\" --filter-name \"SOR3\" \
-filter \"QUAL < 30.0\" --filter-name \"QUAL30\" \
-filter \"FS > 60.0\" --filter-name \"FS60\" \
-filter \"MQRankSum < -12.5\" --filter-name \"MQRankSum12.5\" \
-filter \"ReadPosRankSum < -8.0\" --filter-name \"ReadPosRankSum-8\" -O ${outdir}/vcf/${sample}.snp.filter.vcf.gz" && echo "** 4 ${sample}.snp.filter.HC.vcf.gz done ** "

${SINGULARITY_EXEC}"gatk SelectVariants -select-type INDEL -V ${outdir}/vcf/${sample}.HC.vcf.gz  -O ${outdir}/vcf/${sample}.indel.vcf.gz"

${SINGULARITY_EXEC}"gatk VariantFiltration -V ${outdir}/vcf/${sample}.indel.vcf.gz -filter \"QD < 2.0\" --filter-name \"QD2\" \
-filter \"SOR > 3.0\" --filter-name \"SOR3\" \
-filter \"QUAL < 30.0\" --filter-name \"QUAL30\" \
-filter \"FS > 60.0\" --filter-name \"FS60\" \
-filter \"MQRankSum < -12.5\" --filter-name \"MQRankSum12.5\" \
-filter \"ReadPosRankSum < -8.0\" --filter-name \"ReadPosRankSum-8\" -O ${outdir}/vcf/${sample}.indel.filter.vcf.gz " && echo "** 5 ${sample}.indel.filter.HC.vcf.gz done ** "

${SINGULARITY_EXEC}"gatk MergeVcfs -I ${outdir}/vcf/${sample}.snp.filter.vcf.gz -I ${outdir}/vcf/${sample}.indel.filter.vcf.gz -O ${outdir}/vcf/${sample}.filter.vcf.gz " && echo "** 6 ${sample}.conbine.filter.HC.vcf.gz done ** "

gzip -d ${outdir}/vcf/${sample}.filter.vcf.gz && echo "** 7 tar done ** "

awk '/^#/||$7=="PASS"' ${outdir}/vcf/${sample}.filter.vcf > ${outdir}/vcf/${sample}.filter.out.vcf

perl /home/annovar/convert2annovar.pl -format vcf4 ${outdir}/vcf/${sample}.filter.out.vcf > /${outdir}/vcf/${sample}.filter.out.annovar && echo "** 8 change type done **"

perl /home/annovar/table_annovar.pl ${outdir}/vcf/${sample}.filter.out.annovar /home/WGS/mousedb/ -buildver mm10 -out ${outdir}/vcf/${sample}.variants --otherinfo -remove -protocol refGene -operation g -nastring NA && echo "** 9 all done ** "
