#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N HELA_1
#$ -l s_vmem=3G,mem_req=3G
#$ -l epyc
#$ -pe def_slot 30
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir SRR2814761 ../workflows/preprocessing.cwl HELA_1pre.job.yaml
