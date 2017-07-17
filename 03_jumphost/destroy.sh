#!/bin/bash

terraform destroy -force -var-file ../02_kops/tfvars.output
