#!/bin/bash

terraform destroy -force -var-file ../01_init/tfvars.output
export NAME=$()
export KOPS_STATE_STORE=$()
kops delete cluster ${NAME}
