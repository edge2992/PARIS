#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: samtools-sam2bam-v1.9
label: samtools-sam2bam-v1.9

requirements:
    InlineJavascriptRequirement: {}
    DockerRequirement:
        dockerPull: quay.io/biocontainers/samtools:1.7--0

baseCommand: [ samtools, view, -bS ]

inputs:
  sam:
    type: File
    doc: Input SAM file
  threads:
    type: int
    default: 1
    inputBinding:
      prefix: -@


arguments:
   - $(inputs.sam)

stdout: $(inputs.sam.nameroot).bam
# stderr: samtools.log 

outputs:
  - id: bam
    type: stdout
#  - id: loga
#    type: stderr

