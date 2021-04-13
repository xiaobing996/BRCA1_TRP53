1. FastQC
/path_to_fastqc/FastQC/fastqc untreated.fq -o fastqc_out_dir/
2.Trimmomatic
java -jar /path/Trimmomatic/trimmomatic-0.36.jar PE -phred33 -trimlog logfile reads_1.fq.gz reads_2.fq.gz out.read_1.fq.gz out.trim.read_1.fq.gz out.read_2.fq.gz out.trim.read_2.fq.gz ILLUMINACLIP:/path/Trimmomatic/adapters/TruSeq3-PE.fa:2:30:10 SLIDINGWINDOW:5:20 LEADING:5 TRAILING:5 MINLEN:50
