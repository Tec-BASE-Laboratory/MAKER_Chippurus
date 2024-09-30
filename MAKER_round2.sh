#!/bin/bash

# C. hippurus Annotation - Round 2 with SNAP
# Edit maker_opts.ctl as follows

# Step 1: Generate the default MAKER control files
echo "Generating default MAKER control files..."
./maker -CTL

# Step 2: Edit the maker_opts.ctl file
echo "Editing maker_opts.ctl for Round 2 with SNAP..."
nano maker_opts.ctl

# Make the following changes to 'maker_opts.ctl' file (you can automate it by editing with 'sed' or 'echo' commands)
: '
#-----Genome (these are always required)
genome=/users/shinojosa/dorado_illumina/genome/assembly3.fasta
organism_type=eukaryotic

#-----Re-annotation Using MAKER Derived GFF3
maker_gff=/users/shinojosa/maker/bin/snap3/doradorun2_assembly3_reformatted.all.gff
est_pass=1
altest_pass=0
protein_pass=1
rm_pass=1
model_pass=0
pred_pass=0
other_pass=0

#-----Protein Homology Evidence
protein=
protein_gff=/users/shinojosa/maker/bin/doradorun1_assembly3_reformatted.maker.output/doradorun1_all.maker.protein2genome.gff

#-----Gene Prediction
snaphmm=/users/shinojosa/maker/bin/dorado.hmm
'

# Step 3: Run MAKER with the modified options
echo "Running MAKER for Round 2 with SNAP..."
screen ./maker maker_opts.ctl maker_bopts.ctl maker_exe.ctl -base doradorun2_assembly3_reformatted -cpus 40

echo "MAKER Round 2 initiated!"
