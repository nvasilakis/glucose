#!/bin/bash
# A tiny automation script that generates tests for a 
# given input and outputs results on file and stdout.

if [ $# -eq 0 ]; then
  echo -e "\n You have not specified any source files
 That is $0 <file1.c> <file2.c>..\n";
else
  for file in $*; do
    if [[ ! -f "$file" ]]; then
      echo -e "File $file is not in `pwd` \n";
      exit 1;
    fi
  done
fi

# TODO: in order to rename results incrementally as KLEE
# does, we need to get last KLEE build number. Smth like
# if [[ ${file: -4} ~= /regex/ ]]
results="results1.txt"

if [[ -f "$results" ]]; then
  rm "$results";
fi
touch "$results";

for file in $*; do
  echo -e "\n[$file][Compiling to LLVM bitcode]\n";
  llvm-gcc.cde --emit-llvm -c -g $file;
  echo -e "[$file][Running KLEE]\n";
  klee.cde `echo $file | sed "s/c$/o/"`;
  echo -e "\n[$file][Outputting results]\n";
  echo -e "\n\n Test results for [$file]\n\n" | tee -a "$results";
  ktest-tool.cde klee-last/test*.ktest | tee -a "$results";
done