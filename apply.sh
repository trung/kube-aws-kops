#!/bin/bash

pushd 01_init
terraform apply
popd

pushd 02_kops
terraform apply -var-file=../01_init/tfvars.output
popd

pushd 03_jumphost
terraform apply -var-file=../02_kops/tfvars.output
popd
