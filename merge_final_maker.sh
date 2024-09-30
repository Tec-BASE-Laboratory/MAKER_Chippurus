#!/bin/bash

# Step 1: Merge GFF3 files
echo "Merging GFF3 files..."
../gff3_merge -n -d doradorun2_assembly3_reformatted_master_datastore_index.log

# Step 2: Merge FASTA files
echo "Merging FASTA files..."
../fasta_merge -d doradorun2_assembly3_reformatted_master_datastore_index.log

# Step 3: Map GFF IDs
echo "Mapping GFF IDs..."
../map_gff_ids dorado

# Step 4: Map GFF IDs using the generated map and the renamed GFF file
echo "Mapping GFF IDs for renamed GFF file..."
../map_gff_ids dorado.all.id.map C_hippurus_renamed.gff

# Step 5: Map FASTA IDs for proteins
echo "Mapping FASTA IDs for proteins..."
../map_fasta_ids dorado.all.id.map C_hippurus_renamed.proteins.fasta

# Step 6: Map FASTA IDs for transcripts
echo "Mapping FASTA IDs for transcripts..."
../map_fasta_ids dorado.all.id.map C_hippurus_renamed.transcripts.fasta

# Step 7: Map IDs for interproscan data
echo "Mapping IDs for interproscan data..."
../map_data_ids dorado.all.id.map interpro.renamed.iprscan

# Step 8: Map IDs for BLASTP output
echo "Mapping IDs for BLASTP output..."
../map_data_ids dorado.all.id.map output.renamed.blastp

# Step 9: Generate functional GFF file using MAKER annotations
echo "Generating functional GFF file..."
../maker_functional_gff /users/shinojosa/dorado_illumina/genome/uniprot_sprot.fasta output.renamed.blastp C_hippurus_renamed.gff > C_hippurus_renamed.putative_function.gff

# Step 10: Generate putative functional FASTA file for proteins
echo "Generating putative functional FASTA for proteins..."
../maker_functional_fasta /users/shinojosa/dorado_illumina/genome/uniprot_sprot.fasta output.renamed.blastp C_hippurus_renamed.proteins.fasta > C_hippurus_renamed.proteins.putative_function.fasta

# Step 11: Generate putative functional FASTA file for transcripts
echo "Generating putative functional FASTA for transcripts..."
../maker_functional_fasta /users/shinojosa/dorado_illumina/genome/uniprot_sprot.fasta output.renamed.blastp C_hippurus_renamed.transcripts.fasta > C_hippurus_renamed.transcripts.putative_function.fasta

echo "Process completed!"
