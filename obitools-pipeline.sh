#OBITools pipeline 

fastqc <filename> #quality control
gunzip <filename> #Unzip files (The input file is the raw data in fastq file)
obicount <filename> #check number of reads 

#Paired-end alignment and split good and bad alignments
illuminapairedend -r EV_Lib1_1.fq EV_Lib1_2.fq | \
obiannotate -S "goodali:'Good_CODE' if score > 30.00 else 'Bad_CODE'" | \
obisplit -t goodali

#Demultiplex files using ngs filter 
ngsfilter -t <NGSfilterfile> —-fasta-output -u unidentified_CODE.fasta Good_CODE.fasta> CODE.filtered.fasta
# It's possible to change the file type of the output 
# Standard output format
#       --fasta-output
#              Output sequences in OBITools fasta format
#
#       --fastq-output
#              Output sequences in Sanger fastq format
#
#   Generating an ecoPCR database
#       --ecopcrdb-output=<PREFIX_FILENAME>
#              Creates an ecoPCR database from sequence records results
#
#   Miscellaneous option
#       --uppercase
#              Print sequences in upper case (default is lower case)
#
#Filter sequences by size
#The size depends of the primer that was used. In this case, I used Teleo2 primer that have approximately 160 bp
obigrep -p 'seq_length>130' -p 'seq_length<190' -s '^[ACGT]+$' CODE.filtered.fasta > CODEfiltered_size.fasta

obistat -c sample -a seq_length CODEfiltered_size.fasta > sample_stats_CODE.filtered_length.txt #Calculate per sample statistics (optional)

#Dereplicate reads into unique sequences
obiuniq -m sample CODEfiltered_size.fasta > CODE.unique.fasta


#Chimera detection with VSEARCH
#May need to do this first in R 
R
install.packages("renv")
library(renv)
renv::init()

#restart R by quitting and re-launching 
quit()
#when asked to save the workspace select 'y'
#re-load R
R

#install and load packages 
if(!require("BiocManager", quietly=TRUE))
  install.packages("BiocManager")
BiocManager::install("Biostrings")
library(Biostrings)
install.packages("optparse")
library(optparse)
quit()
#when asked to save the workspace select 'y'

#convert to vsearch format
owu_obifasta2vsearch -i CODE.unique.fasta -o CODE.unique.vsearch.fasta

#modify format of vsearch fasta file without having to open and edit in vim
sed 's/ ;/;/g' CODE.unique.vsearch.fasta > CODE.unique.vsearch.mod.fasta

#chimera detection
vsearch --uchime_denovo CODE.unique.vsearch.mod.fasta --sizeout --nonchimeras CODE.nonchimeras.fasta --chimeras CODE.chimeras.fasta --threads 28 -- uchimeout CODE.uchimeout.txt

##Clustering with swarm
#used a d-value of 1 
swarm -d 1 -f -z -t 20 -o CODE_SWARM1_output -s CODE_SWARM1_stats -w CODE_SWARM1_seeds.fasta CODE.nonchimeras.fasta

#recount abundance by samples 
obitab -o CODE.unique.fasta > CODE.new.tab
owi_recount_swarm CODE_swarm_output CODE.new.tab

##Taxonomic assignment using sintax 
vsearch --threads "$THREADS" --sintax CODE_SWARM1_seeds.fasta --db REF_DB.sintax.v255.fasta --sintax_cutoff 0.7 --tabbedout SWARM1_sintax_output_lib1.tsv
