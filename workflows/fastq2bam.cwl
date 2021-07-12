#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  StepInputExpressionRequirement: {}
  InlineJavascriptRequirement: {}

inputs:
  reference:
    type: Directory
  fastq:
    type: File
    doc: Input FASTQ file for Read
  outprefix:
    type: string
    doc: Any string that can distinguish sample.
  multimapN:
    type: int
    default: 10
    doc: max number of multiple alignments allowed for a read unmapped
  threads:
    type: int
    default: 1
    doc: Number of threads for parallel processing

steps:
  star_align:
    run: ../tools/star-align.cwl
    in:
      refdir: reference
      fastq: fastq
      outprefix: outprefix
      threads: threads
    out: [alignedsam, chimericsam, junction, log]

  sam2bam:
    run: ../tools/samtools-sam2bam.cwl
    in:
      sam: star_align/alignedsam
      threads: threads
    out: [bam]

  sort_bam:
    run: ../tools/samtools-sort.cwl
    in:
      bam: sam2bam/bam
      threads: threads
    out: [sorted_bam]

  primary:
    run: ../tools/samtools-primary.cwl
    in:
      bam: sort_bam/sorted_bam
      threads: threads
    out: [bam]

  bam2sam:
    run: ../tools/samtools-bam2sam.cwl
    in:
      bam: primary/bam
      threads: threads
    out: [sam]

  gapped:
    run: ../tools/gapped.cwl
    in:
      sam: bam2sam/sam
    out: [sam]

  header:
    run: ../tools/samtools-view-header.cwl
    in:
      sam: star_align/alignedsam
    out: [header]

  add:
    run: ../tools/cat-add.cwl
    in:
      header: header/header
      content: gapped/sam
    out: [prim_nh]

  sam2bam_igv:
    run: ../tools/samtools-sam2bam.cwl
    in:
      sam: add/prim_nh
      threads: threads
    out: [bam]

  sort_bam_igv:
    run: ../tools/samtools-sort.cwl
    in:
      bam: sam2bam_igv/bam
      threads: threads
    out: [sorted_bam]

  index:
    run: ../tools/samtools-index.cwl
    in:
      bam: sort_bam_igv/sorted_bam
      threads: threads
    out: [bai]

outputs:
    gapped_sam:
      type: File
      outputSource: add/prim_nh
    gapped_sorted_bam:
      type: File
      outputSource: sort_bam_igv/sorted_bam
    gapped_bai:
      type: File
      outputSource: index/bai
    alignedsam:
      type: File
      outputSource: star_align/alignedsam
    chimericsam:
      type: File
      outputSource: star_align/chimericsam
    junction:
      type: File
      outputSource: star_align/junction
    log:
      type: File
      outputSource: star_align/log
