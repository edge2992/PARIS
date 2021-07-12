#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N f2b_bc01
#$ -l s_vmem=3G,mem_req=3G
#$ -l epyc
#$ -pe def_slot 30
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir SRR2814761 ../workflows/fastq2bam.cwl HeLa1_bc01f2b.job.yaml
