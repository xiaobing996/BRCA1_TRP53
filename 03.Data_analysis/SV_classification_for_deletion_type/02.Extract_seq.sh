###step2 extract seq
bedtools intersect -header  -a /home/WGS/reference/ucsc.mm10.fa -b SV_pos_extract.bed > SV_pos_extract.fa