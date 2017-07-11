#!/bin/bash

cd 01_init
tf apply

cd 02_kops
tf apply -var-file=../01_init/tfvars.output

cd 03_jumphost
tf apply -var-file=../02_kops/tfvars.output
