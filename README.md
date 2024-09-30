# MAKER_Chippurus
Full description of commands used for annotate de Mahi mahi genome, with SNAP and AUGUSTUS 
Install MAKER:
https://github.com/Yandell-Lab/maker

We used the following tutoraials as base for the annotation.
1.https://darencard.net/blog/2017-05-16-maker-genome-annotation/
2.http://weatherby.genetics.utah.edu/MAKER/wiki/index.php/MAKER_Tutorial_for_WGS_Assembly_and_Annotation_Winter_School_2018

Prior launching Maker the following programs are run independently
1. blastp with a database of closely related species
2. interpro scan with https://www.uniprot.org/help/downloads Swiss-Prot
3. RepeatMasker https://www.repeatmasker.org/cgi-bin/WEBRepeatMasker
4. AUGUSTUS https://github.com/Gaius-Augustus/Augustus
5. SNAP https://hpc.nih.gov/apps/snap.html

The scripts for AUGUSTUS and SNAP are for run separatedly 
The script  MAKER_round1 is a round using RNAseq data, similar species proteins with out gene prediction support
The script MAKER_round2 is a round using  gene prediction (Augustus or SNAP) 
Remember to evaluate each round, is important to  at least run MAKER 3 times

Run the following commands after each round to evaluate:
Count number of genes
  $cat your.gff | awk '{ if ($3 == "gene") print $0 }' | awk '{ sum += ($5 - $4) } END { print NR, sum / NR }'
On MAKER/bin
  $perl AED_cdf_generator.pl -b 0.025 your.gff

Finally run the merge_final_make.sh to obtain finall outputfiles
