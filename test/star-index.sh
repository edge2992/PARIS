#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -N star-index
#$ -l s_vmem=4G,mem_req=4G
#$ -l epyc
#$ -pe def_slot 30 
#$ -o ./log
#$ -e ./log

cwltool --singularity \
  --outdir ../reference/RefSeq \
  --debug \
  ../tools/star-index-transcripts.cwl star-index.job.yaml

