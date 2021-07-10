#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N preprocess
#$ -l s_vmem=8G,mem_req=8G
#$ -l epyc
#$ -pe def_slot 8

cwltool --singularity \
  --outdir SRR2814766 ../workflows/preprocessing.cwl preprocessing.job.yaml
