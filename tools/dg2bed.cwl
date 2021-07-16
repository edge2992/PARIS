#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: DG2bed
label: DG2bed

requirements:
  InlineJavascriptRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.fastq)

baseCommand: [ /usr/bin/python, /home/edge2992/myprojects/PARIS/tools/duplex/dg2bed.py ]

inputs:
  geometric:
    type: File

arguments:
  - $(inputs.geometric)
  - $(inputs.geometric.basename)RG.bed
  - bed12

outputs:
  - id: bed
    type: File
    outputBinding:
      glob: $(inputs.geometric.basename)RG.bed
