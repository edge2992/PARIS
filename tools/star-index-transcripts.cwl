#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: star-index-v2.4.8a
label: star-index-v2.4.8a

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: biocontainers/star:2.7.8a--0

baseCommand: [STAR, --runMode genomeGenerate]

arguments:
inputs:
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: --runThreadN
  reference:
    type: File
    doc: FASTA file for reference genome
    inputBinding:
      prefix: --genomeFastaFiles
  SAindexN:
    type: int
    inputBinding:
      prefix: --genomeSAindexNbases

outputs:
  # - id: amb
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).amb
  # - id: ann
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).ann
  # - id: bwt
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).bwt
  # - id: pac
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).pac
  # - id: sa
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.reference.basename).sa
  # - id: log
  #   type: stderr

# stderr: $(inputs.reference.basename).bwa-index.log



