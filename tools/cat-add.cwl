#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: cat-add
label: cat-add

requirements:
  InlineJavascriptRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.fastq)

baseCommand: [cat]

inputs:
  header:
    type: File
    inputBinding:
      position: 1
  content:
    type: File
    inputBinding:
      position: 2

stdout: $(inputs.content.basename.split('.')[0])h.sam

outputs:
  - id: prim_nh
    type: stdout


