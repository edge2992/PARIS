#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: samtools-sam2bam-v1.9
label: samtools-sam2bam-v1.9

requirements:
    InlineJavascriptRequirement: {}
    DockerRequirement:
        dockerPull: quay.io/biocontainers/samtools:1.9--h10a08f8_12


baseCommand: [ samtools, view, -b ]

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
   - -F 0x900

stdout: $(inputs.bam.nameroot)_prim.bam
# stderr: samtools.log 

outputs:
  - id: bam
    type: stdout
#  - id: loga
#    type: stderr

