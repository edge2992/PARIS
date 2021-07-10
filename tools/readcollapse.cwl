#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: readcollapse
label: readcollapse

requirements:
  InlineJavascriptRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.fastq)

baseCommand: [ /home/edge2992/myprojects/PARIS/tools/icSHAPE/bin/readCollapse ]

inputs:
  fastq:
    type: File

arguments:
  - $(inputs.fastq)
  - $(inputs.fastq.basename.replace(/\.fq$|\.fastq$/, ''))_nodup.fastq
  # - $(inputs.fastq.basename)_unique.fastq

outputs:
  - id: nodup
    type: File
    outputBinding:
      glob: $(inputs.fastq.basename.replace(/\.fq$|\.fastq$/, ''))_nodup.fastq
  # - id: unique
  #   type: File
  #   outputBinding:
  #      glob: $(inputs.fastq.basename)_unique.fastq


