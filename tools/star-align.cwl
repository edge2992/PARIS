#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: star-align:2.7.8
label: star-align:2.7.8

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/star:2.7.8a--0

baseCommand: [ STAR, --runMode, alignReads ]

inputs:
  refdir:
    type: Directory
    inputBinding:
      prefix: --genomeDir
  fastq:
    type: File
    inputBinding:
      prefix: --readFilesIn
  outprefix:
    type: string?
    default: "xxxx"
  multimapN:
    type: int?
    inputBinding:
      prefix: --outFilterMultimapNmax
  threads:
    type: int?
    default: 1
    inputBinding:
      prefix: --runThreadN

arguments:
  - --outSAMtype SAM
  - --chimOutType Junctions SeparateSAMold
  - --outFileNamePrefix star/$(inputs.outprefix)_
  - --outReadsUnmapped Fastq
  - --outSAMattributes NH HI AS nM NM MD jM jI MC
  - --alignIntronMin 1
  - --scoreGapNoncan -4
  - --scoreGapATAC -4
  - --chimSegmentMin 15
  - --chimJunctionOverhangMin 15

outputs:
  - id: alignedsam
    type: File
    outputBinding:
      glob: star/$(inputs.outprefix)_Aligned.out.sam
  - id: chimericsam
    type: File
    outputBinding:
      glob: star/$(inputs.outprefix)_Chimeric.out.sam
  - id: junction
    type: File
    outputBinding:
      glob: star/$(inputs.outprefix)_Chimeric.out.junction
  - id: log
    type: File
    outputBinding:
      glob: star/$(inputs.outprefix)_Log.final.out

