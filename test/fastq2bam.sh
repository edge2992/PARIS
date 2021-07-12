#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N sample1
#$ -l s_vmem=4G,mem_req=4G
#$ -l epyc
#$ -pe def_slot 16
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir tmp2 ../workflows/fastq2bam.cwl fastq2bam.job.yaml
