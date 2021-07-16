#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N aa
#$ -l s_vmem=8G,mem_req=8G
#$ -l epyc
#$ -pe def_slot 5
#$ -o ./log
#$ -e ./log

# cwltool --singularity \
#   --outdir SRR2814761/DG ../workflows/dg.cwl dg.job.yaml
cwltool --singularity ../tools/samtools-sam2bam.cwl --sam ../SRA/SRR2814766.sra_trim_nodup_bc01_starSS_geometric_NG-min.sam

