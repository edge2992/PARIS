#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: fastqc:0.11.9--0
label: fastqc:0.11.9--0

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/fastqc:0.11.9--0

baseCommand: [fastqc, --outdir, . ]

inputs:
  fastq:
    type: File
    inputBinding:
      position: 1
  threads:
    type: int?
    default: 1
    inputBinding:
      position: 2
      prefix: -t

outputs:
  html:
    type: File
    outputBinding:
      glob: "*.html"
  zippedFile:
    type: File
    outputBinding:
      glob: "*.zip"
  # compress:
  #   type: File
  #   outputBinding:
  #     glob: "*.zip"

