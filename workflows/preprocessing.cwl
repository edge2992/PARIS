#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}
  ScatterFeatureRequirement: {}
inputs:
  fastq:
    type: File
  adapter:
    type: File
  threads:
    type: int?
    default: 1
  barcode:
    type: string

steps:
  trim3_adapter:
    run: ../tools/trimmomatic-3end.cwl
    in:
      fastq: fastq
      adapter: adapter
      threads: threads
    out: [trim, summary]

  readcollapse:
    run: ../tools/readcollapse.cwl
    in:
      fastq: trim3_adapter/trim
    out: [ nodup ]

  splitfastq:
    run: ../tools/splitfastqlibrary.cwl
    in:
      fastq: readcollapse/nodup
      barcode: barcode
    out: [ barcode_stat, splited ]

  trim5_adapter:
    run: ../tools/trimmomatic-5end.cwl
    scatter: fastq
    in:
      fastq: splitfastq/splited
      threads: threads
    out: [trim, summary]

outputs:
  summary3:
    type: File
    outputSource: trim3_adapter/summary
  summary5:
    type: File[]
    outputSource: trim5_adapter/summary
  barcode_stat:
    type: File
    outputSource: splitfastq/barcode_stat
  trim:
    type: File[]
    outputSource: trim5_adapter/trim
