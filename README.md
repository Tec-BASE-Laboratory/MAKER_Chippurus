# MAKER_Chyppurus
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

Here is the commands used for each run of MAKER, as well the .ctl files. We also add how to run AUGUSTUS and SNAP
