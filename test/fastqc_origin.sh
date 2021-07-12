#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N origin61
#$ -l s_vmem=2G,mem_req=2G
#$ -l epyc
#$ -pe def_slot 15
#$ -o ./log
#$ -e ./log

# cwltool --singularity \
#   --outdir tmp ../tools/fastqc.cwl fastqc.job.yaml

cwltool --singularity \
  --outdir SRR2814761 ../tools/fastqc.cwl fastqc.job.yaml
