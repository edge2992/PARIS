#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N HELA_1
#$ -l s_vmem=8G,mem_req=8G
#$ -l epyc
#$ -pe def_slot 16
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir SRR2814761 ../workflows/preprocessing.cwl HELA_1pre.job.yaml
