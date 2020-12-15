#!/bin/bash

# default + extensible
for A in Default Final Extensible Mutable MutableExplicitID; do
  for N in 1 2 3 4 5; do
    for B in Default Final Extensible Mutable MutableExplicitID; do
      for M in 1 2 3 4 5; do
        CMD="./simple.sh Shape${N}${A} Shape${M}${B}"
        echo $CMD
        $CMD
      done
    done
  done
done


