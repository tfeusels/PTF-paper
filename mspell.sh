#!/bin/bash

for file in "$@"   # "$@" contains all the command line arguments passed to the program
do
  aspell -d en_US-wo_accents -t -c $file
done