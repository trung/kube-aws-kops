#!/bin/bash

order=("03_jumphost" "02_kops" "01_init")

for m in ${order[@]}; do
  pushd $m
  ./destroy.sh
  popd
done

