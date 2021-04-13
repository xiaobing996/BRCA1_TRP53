gzip -d /home/WGS/mousedb/mm10_refGene.txt.gz
perl /home/annovar/retrieve_seq_from_fasta.pl --format refGene --seqfile /home/WGS/reference/ucsc.mm10.fa /home/WGS/mousedb/mm10_refGene.txt --out /home/WGS/mousedb/mm10_refGeneMrna.fa
