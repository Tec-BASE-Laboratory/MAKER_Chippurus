#!/bin/bash

# Step 1: Convert MAKER output to ZFF format using maker2zff
# Make sure you have completed a MAKER run and have output files (e.g., *.gff)

echo "Converting MAKER output to ZFF format..."
cd maker_output_directory  # Navigate to your MAKER output directory

# Run maker2zff to convert the MAKER annotations to ZFF format
maker2zff -n -d maker_run_name_master_datastore_index.log

# Check if ZFF files were generated
if [ ! -f genome.ann ] || [ ! -f genome.dna ]; then
    echo "Error: ZFF files (genome.ann and genome.dna) were not created!"
    exit 1
fi

echo "ZFF files created: genome.ann and genome.dna"

# Step 2: Convert ZFF format to GenBank (.gb) using fathom
# You will use SNAP's fathom command to generate the necessary .gb file from ZFF

echo "Converting ZFF files to GenBank format..."

# Categorize and prepare the ZFF annotations
fathom genome.ann genome.dna -categorize 1000

# Export the data in a format that can be converted to GenBank
fathom uni.ann uni.dna -export 1000 -plus

# Create a GenBank (.gb) file from the exported ZFF data
perl /users/shinojosa/snap/hmm-assembler.pl dorado . > dorado2.gb

# Check if the GenBank file was created successfully
if [ ! -f dorado2.gb ]; then
    echo "Error: GenBank (.gb) file was not created!"
    exit 1
fi

echo "GenBank (.gb) file created: dorado2.gb"
#NOTE: EXPORT AUGUSTUS Configuration file  export AUGUSTUS_CONFIG_PATH=/workdir/$USER/augustus_config/
# Step 3: Split the GenBank file into training and test sets
perl /users/shinojosa/Augustus/scripts/randomSplit.pl dorado2.gb 1000

# Step 4: Optimize AUGUSTUS parameters using the first configuration
perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=hh --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test

# Step 5: Optimize AUGUSTUS parameters using dorado2 species configuration
perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=dorado2 --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test

# Step 6: Run optimization in a detached screen session named 'agugustus5rounds' and log output to a file
screen -S agugustus5rounds perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=dorado2 --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test >& log &

# Additional screen commands to run optimization (if needed)
screen -S agugustus5rounds perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=dorado2 --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test
screen -S agugustus5rounds perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=dorado2 --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test

# Step 7: Final optimization run without screen session
perl /users/shinojosa/Augustus/scripts/optimize_augustus.pl --species=dorado2 --kfold=24 --cpus=24 --rounds=5 --onlytrain=dorado2.gb.train dorado2.gb.test

# Step 8: Training with etraining command using dorado2 species model
etraining --species=dorado2 dorado2.gb

# Step 9: Run AUGUSTUS on the evaluation set and save output to second2_evaluate.out
augustus --species=dorado2 dorado2.gb.evaluation >& second2_evaluate.out

echo "AUGUSTUS optimization and training completed!"
