cd /home/WGS/for_repeatmark/
###step1 get the sequenece in postion
bedtools getfasta -fi /home/WGS/reference/ucsc.mm10.fa  -bed pos.txt -fo SV_pos.fa
###step2 
/home/RepeatMasker2/RepeatMasker/RepeatMasker -parallel 30 -species mouse -html -gff -dir /home/WGS/for_repeatmark/result_data/ SV_pos.fa
