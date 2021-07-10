#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: trimmomatic-5end:0.39
label: trimmomatic-5end:0.39

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.39--hdfd78af_2

baseCommand: [/usr/local/bin/trimmomatic, SE]

inputs:
  fastq:
    type: File
  outprefix:
    type: string?
    default: "out"
  threads:
    type: int?
    default: 1
    
arguments:
  - -threads
  - $(inputs.threads)
  - -phred33
  - -trimlog
  - $(inputs.fastq.basename).trimmomatic.log.txt
  - -summary
  - $(inputs.fastq.basename).trimmomatic.summary.txt
  - $(inputs.fastq)
  - $(inputs.fastq.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '').replace('trim3', 'trim')).fastq
  - HEADCROP:15
  - MINLEN:20

outputs:
  trim:
    type: File
    outputBinding:
      glob: $(inputs.fastq.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, '').replace('trim3', 'trim')).fastq
  # log:
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.outprefix).trimmomatic.log.txt
  summary:
    type: File
    outputBinding:
      glob: $(inputs.fastq.basename).trimmomatic.summary.txt
