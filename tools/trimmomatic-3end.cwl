#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool

id: trimmomatic-3end:0.39
label: trimmomatic-3end:0.39

requirements:
  InlineJavascriptRequirement: {}
  DockerRequirement:
    dockerPull: quay.io/biocontainers/trimmomatic:0.39--hdfd78af_2

baseCommand: [/usr/local/bin/trimmomatic, SE]

inputs:
  fastq:
    type: File
  adapter:
    type: File
  outprefix:
    type: string?
    default: "trim3"
  threads:
    type: int?
    default: 1

arguments:
  - -threads
  - $(inputs.threads)
  - -phred33
  - -trimlog
  - $(inputs.outprefix).trimmomatic.log.txt
  - -summary
  - $(inputs.outprefix).trimmomatic.summary.txt
  - $(inputs.fastq)
  - $(inputs.fastq.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, ''))_trim3.fastq
  - ILLUMINACLIP:$(inputs.adapter.path):3:20:10
  - SLIDINGWINDOW:10:30
  - MINLEN:28

outputs:
  trim:
    type: File
    outputBinding:
      glob: $(inputs.fastq.basename.replace(/\.gz$|\.bz2$/, '').replace(/\.fq$|\.fastq$/, ''))_trim3.fastq
  # log:
  #   type: File
  #   outputBinding:
  #     glob: $(inputs.outprefix).trimmomatic.log.txt
  summary:
    type: File
    outputBinding:
      glob: $(inputs.outprefix).trimmomatic.summary.txt
