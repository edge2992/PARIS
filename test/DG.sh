#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N DG
#$ -l s_vmem=8G,mem_req=8G
#$ -l epyc
#$ -pe def_slot 5
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir SRR2814761/DG ../workflows/dg.cwl dg.job.yaml
