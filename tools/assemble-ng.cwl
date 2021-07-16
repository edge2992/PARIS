#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: Assemble-NG
label: Assemble-NG

requirements:
  InlineJavascriptRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.fastq)

baseCommand: [ /usr/bin/python, /home/edge2992/myprojects/PARIS/tools/duplex/sam2ngmin.py ]

inputs:
  geometricsam:
    type: File

arguments:
  - $(inputs.geometricsam)
  - $(inputs.geometricsam.basename.replace(/sam$/, ''))_NG-min.sam

outputs:
  - id: NGsam
    type: File
    outputBinding:
      glob:  $(inputs.geometricsam.basename.replace(/sam$/, ''))_NG-min.sam
