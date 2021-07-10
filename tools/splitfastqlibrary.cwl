#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: splitfastqlibrary
label: bamfilter

requirements:
  InlineJavascriptRequirement: {}
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.fastq)


baseCommand: [ perl, /home/edge2992/myprojects/PARIS/tools/icSHAPE/scripts/splitFastq.pl ]

inputs:
  fastq:
    type: File
    inputBinding:
      position: 1
      prefix: -U
  barcode:
    type: string
    inputBinding:
      position: 2
      prefix: -l

arguments:
  - valueFrom: 6:4
    prefix: -b
    position: 3
  - valueFrom: tmp
    prefix: -d
    position: 4
  - valueFrom: barcord.stat
    prefix: -s
    position: 5

outputs:
  - id: barcode_stat
    type: File
    outputBinding:
      glob: barcord.stat
  - id: splited
    type:
      type: array
      items: File
    outputBinding:
      glob: tmp/*.fastq

