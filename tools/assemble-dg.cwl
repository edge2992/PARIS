#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: Assemble-DG
label: Assemble-DG

requirements:
  InlineJavascriptRequirement: {}
  # InitialWorkDirRequirement:
  #   listing:
  #     - entry: $(inputs.fastq)

baseCommand: [ perl, /home/edge2992/myprojects/PARIS/tools/paris/samPairingCalling.test.pl ]

inputs:
  sam:
    type: File
    inputBinding:
      prefix: -i
  junction:
    type: File
    inputBinding:
      prefix: -j
  junction_sam:
    type: File
    inputBinding:
      prefix: -s
  genome:
    type: File?
    inputBinding:
      prefix: -g
  genome_size:
    type: File?
    inputBinding:
      prefix: -z
  transcriptome:
    type: File?
    inputBinding:
      prefix: -t

arguments:
  - prefix: "-o"
    valueFrom: $(inputs.sam.basename.replace(/.sam$/, ''))_geometric
  - -l 15
  - -p 2
  - -c geometric

outputs:
  - id: geometricsam
    type: File
    outputBinding:
      glob: $(inputs.sam.basename.replace(/.sam$/, ''))_geometricsam
  - id: geometricreads
    type: File
    outputBinding:
      glob: $(inputs.sam.basename.replace(/.sam$/, ''))_geometricreads
  - id: geometric
    type: File
    outputBinding:
      glob: $(inputs.sam.basename.replace(/.sam$/, ''))_geometric

