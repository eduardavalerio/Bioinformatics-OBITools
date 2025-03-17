# OBITools pipeline 

**Quality control**

`fastqc <filename>`

**Unzip files** (The input file is the raw data in fastq file)

`gunzip <filename>`

**Check number of reads using obicount** 

`obicount <filename>`

**Paired-end alignment and split good and bad alignments**

`illuminapairedend -r <filename1> <filename2> | obiannotate -S goodali:’”Good_CODE” if score>30.00 else “Bad_CODE”’ | obisplit -t goodali`

**Demultiplex files using NGS file**

`ngsfilter -t <NGSfilterfile> —-fasta-output -u unidentified_CODE.fasta Good_CODE.fastq> CODE.filtered.fasta`

**Filter sequences by size**

The size depends of the primer that was used. In this case, I used Teleo2 primer that have approximately 160 bp

`obigrep -p 'seq_length>130' -p 'seq_length<190' -s '^[ACGT]+$' CODE.filtered.fasta > CODEfiltered_size.fasta`

**Calculate per sample statistics (optional)**

`obistat -c sample -a seq_length CODEfiltered_size.fasta > sample_stats_CODE.filtered_length.txt`

**Dereplicate reads into unique sequences**

`obiuniq -m sample EVLAfiltered_size.fasta > EVLA.unique.fasta`

**Chimera deection with VSEARCH**

May need to do this first in R 

`install.packages("renv")`

`library(renv)`

`renv::init()`

#restart R by quitting and re-launching 


