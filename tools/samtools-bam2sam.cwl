#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: samtools-bam2sam-v1.9
label: samtools-bam2sam-v1.9

requirements:
    InlineJavascriptRequirement: {}
    DockerRequirement:
        dockerPull: quay.io/biocontainers/samtools:1.9--h10a08f8_12


baseCommand: [ samtools, view ]

inputs:
  bam:
    type: File
    doc: Input BAM file
  threads:
    type: int
    default: 1
    inputBinding:
      prefix: -@


arguments:
   - $(inputs.bam)


stdout: $(inputs.bam.nameroot).sam
# stderr: samtools.log 

outputs:
  - id: sam
    type: stdout
#  - id: loga
#    type: stderr

