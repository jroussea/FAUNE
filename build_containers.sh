#!/usr/bin/env bash

# PLEASE DO NOT MODIFY THIS FILE (UNLESS YOU KNOW WHAT YOU DOING)

singularity build --fakeroot $PWD/containers/seqkit_2.6.1.sif $PWD/containers/singularity_def_files/seqkit_2.6.1.def
singularity build --fakeroot $PWD/containers/interproscan_5.65-97.0.sif $PWD/containers/singularity_def_files/interproscan_5.65-97.0.def
