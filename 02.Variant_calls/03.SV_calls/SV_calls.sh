reference=/home/WGS/reference/ucsc.mm10.fa
reference_dir=/home/WGS/reference
 delly call -t 15 -g ${reference} \
 -x /home/WGS/reference/mouse.mm10.excl.tsv \
 -o /home/WGS/delly_cellpaper/mydata/Sample.excl1.bcf \
    /home/WGS/output/Sample/bwa/Sample.sorted.markdup.bam \
    /home/WGS/output/control/bwa/control.sorted.markdup.bam  && echo "** call done ** "
