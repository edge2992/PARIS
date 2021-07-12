#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: gapped
label: gapped

requirements:
    InlineJavascriptRequirement: {}

baseCommand: [ awk, '$6 ~ /N/' ]

inputs:
  sam:
    type: File
    doc: Input SAM file
    streamable: true

arguments:
   - $(inputs.sam)

stdout: $(inputs.sam.basename.split('.')[0])_prim_N.sam
# stderr: samtools.log 

outputs:
  - id: sam
    type: stdout
#  - id: loga
#    type: stderr

