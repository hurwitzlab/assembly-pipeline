#!/usr/bin/env bash

set -u #exit if undeclared variable
set -x #echo everything

INPUT="contigs-longer-than-2093.fa"
    
prodigal -d "$INPUT"-prodigal.fa -o "$INPUT"-prodigal.gbk -i $INPUT



