#!/bin/bash

# C. hippurus Annotation - Round 1
# Using transcriptome, proteins from related species, and Uniprot database

# Step 1: Generate the default MAKER control files
echo "Generating default MAKER control files..."
./maker -CTL

# Step 2: Edit the maker_opts.ctl file
echo "Editing maker_opts.ctl with genome, EST, and protein evidence..."
nano maker_opts.ctl

# Make the following changes to 'maker_opts.ctl' file (you can automate it by editing with 'sed' or 'echo' commands)
# Below is the structure for the changes:
: '
#-----Genome (these are always required)
genome=/users/shinojosa/dorado_illumina/genome/assembly3.fasta
organism_type=eukaryotic

#-----Re-annotation Using MAKER Derived GFF3
maker_gff=
est_pass=0
altest_pass=0
protein_pass=0
rm_pass=0
model_pass=0
pred_pass=0
other_pass=0

#-----EST Evidence (for best results provide a file for at least one)
est=/users/shinojosa/dorado_illumina/RNA/trinity_dorado2.Trinity.fasta
est_gff=/users/shinojosa/maker/bin/snap/round1/doradorun1_all.maker.est2genome.gff

#-----Protein Homology Evidence (for best results provide a file for at least one)
protein=/users/shinojosa/dorado_illumina/s_au_pep.fasta,/users/shinojosa/dorado_illumina/fasta/uniprotkb_accession_A0A023G0K5_OR_access_2024_07_30.fasta

#-----Repeat Masking
repeat_protein=/users/shinojosa/maker/data/te_proteins.fasta
rm_gff=/users/shinojosa/dorado_illumina/RepeatMasker/dorado.full_mask.complex.reformat.gff3
softmask=1

#-----Gene Prediction
augustus_species=dorado
est2genome=1
protein2genome=1
trna=0
cpus=40

#-----MAKER Behavior Options
max_dna_len=100000
min_contig=1
pred_flank=200
AED_threshold=1
min_protein=0
split_hit=10000
min_intron=0
single_exon=0
single_length=250
clean_try=0
clean_up=0
'

# Step 3: Run MAKER with the modified options
echo "Running MAKER with modified options..."
screen ./maker maker_opts.ctl maker_bopts.ctl maker_exe.ctl -base doradorun1_assembly3_reformatted -cpus 40

echo "MAKER run initiated!"
