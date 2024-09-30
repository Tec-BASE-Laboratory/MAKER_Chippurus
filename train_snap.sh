#!/bin/bash

# Train SNAP script, 

# Step 1: Create snap1 directory
mkdir snap1

# Step 2: Copy GFF file to snap1 directory
cp doradorun1_assembly3_reformatted.all.gff snap1/

# Step 3: Change directory to snap1
cd snap1/

# Step 4: Change directory to SNAP location
cd /users/shinojosa/snap/

# Step 5: Categorize the genome files
./fathom -categorize 1000 genome.ann genome.dna

# Step 6: Export annotated files
./fathom -export 1000 -plus uni.ann uni.dna

# Step 7: Forge the HMM model
./forge export.ann export.dna

# Step 8: Assemble the HMM file using the provided perl script
perl /users/shinojosa/snap/hmm-assembler.pl dorado . > ../dorado.hmm

echo "SNAP training complete!"
###  NOTE: you might nead to type this command in terminal to make it executable chmod +x train_snap.sh ###
