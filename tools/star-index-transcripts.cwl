#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: star-index-v2.4.8a
label: star-index-v2.4.8a

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/star:2.7.8a--0
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.genomeDir)
        writable: true


baseCommand: [STAR, --runMode, genomeGenerate]

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
    type: int?
    inputBinding:
      prefix: --genomeSAindexNbases
  limitRAM:
    type: long
    default: 40000000000
    inputBinding:
      prefix: --limitGenomeGenerateRAM=
      separate: false
  genomeDir:
    type: Directory
    inputBinding:
      prefix: --genomeDir

arguments:

outputs:
  indices:
    type: Directory
    outputBinding:
      glob: $(inputs.genomeDir.basename)

# stderr: $(inputs.reference.basename).bwa-index.log



