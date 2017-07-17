#!/bin/bash

order=("01_init" "02_kops" "03_jumphost")

for m in ${order[@]}; do
  pushd $m
  ./apply.sh
  popd
done

