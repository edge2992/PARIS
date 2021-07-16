#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  sam:
    type: File
  junction:
    type: File
  junction_sam:
    type: File
  genome:
    type: File?
  genome_size:
    type: File?
  transcriptome:
    type: File?
  threads:
    type: int
    default: 1
    doc: Number of threads for parallel processing

steps:
  # gapped:
  #   run: ../tools/gapped.cwl
  #   in:
  #     sam: junction_sam
  #   out: [sam]

  # header:
  #   run: ../tools/samtools-view-header.cwl
  #   in:
  #     sam: junction_sam
  #   out: [header]

  # add:
  #   run: ../tools/cat-add.cwl
  #   in:
  #     header: header/header
  #     content: gapped/sam
  #   out: [prim_nh]

  assemble-dg:
    run: ../tools/assemble-dg.cwl
    in:
      sam: sam
      junction: junction
      # junction_sam: add/prim_nh
      junction_sam: junction_sam
      genome: genome
      genome_size: genome_size
      transcriptome: transcriptome
    out: [geometricsam, geometricreads, geometric]

  assemble-ng:
    run: ../tools/assemble-ng.cwl
    in:
      geometricsam: assemble-dg/geometricsam
    out: [ NGsam ]

  dg2bed:
    run: ../tools/dg2bed.cwl
    in:
      geometric: assemble-dg/geometric
    out: [bed]

  sam2bam:
    run: ../tools/samtools-sam2bam.cwl
    in:
      sam: assemble-ng/NGsam
      threads: threads
    out: [bam]

  sort_bam:
    run: ../tools/samtools-sort.cwl
    in:
      bam: sam2bam/bam
      threads: threads
    out: [sorted_bam]

  index:
    run: ../tools/samtools-index.cwl
    in:
      bam: sort_bam/sorted_bam
      threads: threads
    out: [bai]

outputs:
  geometricsam:
    type: File
    outputSource: assemble-dg/geometricsam
  geometricreads:
    type: File
    outputSource: assemble-dg/geometricreads
  geometric:
    type: File
    outputSource: assemble-dg/geometric
  arcbed:
    type: File
    outputSource: dg2bed/bed
  sorted_bam:
    type: File
    outputSource: sort_bam/sorted_bam
  bai:
    type: File
    outputSource: index/bai
  ngsam:
    type: File
    outputSource: assemble-ng/NGsam
