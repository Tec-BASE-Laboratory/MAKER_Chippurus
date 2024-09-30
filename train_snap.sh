#!/bin/bash

# Train SNAP script, 

# Step 1: Create snap1 directory
mkdir snap1

# Step 2: Copy GFF file to snap1 directory
cp doradorun1_assembly3_reformatted.all.gff snap1/

# Step 3: Change directory to snap1
cd snap1/

# Step 4: Export the SNAP path
export SNAP_PATH="/users/shinojosa/snap"
export PATH=$SNAP_PATH:$PATH

# Step 5: Categorize the genome files
$SNAP_PATH/fathom -categorize 1000 genome.ann genome.dna

# Step 6: Export annotated files
$SNAP_PATH/fathom -export 1000 -plus uni.ann uni.dna

# Step 7: Forge the HMM model
$SNAP_PATH/forge export.ann export.dna

# Step 8: Assemble the HMM file using the provided perl script
perl $SNAP_PATH/hmm-assembler.pl dorado . > ../dorado.hmm

echo "SNAP training complete!"
###  NOTE: you might nead to type this command in terminal to make it executable chmod +x train_snap.sh ###
