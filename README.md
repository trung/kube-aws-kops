# kube-aws-kops
Kubernetes private cluster in AWS using Kops and Terraform. **All access via a jumphost**

Run `tf plan` and `tf apply` in order:
1. `01_init`: Initialize the infra like: create a new VPC, attach an Internet Gateway, create DNS, S3 Bucket for kops state store
   ```
   tf apply
   ```
1. `02_kops`: Run `kops create cluster` to generate Terraform templates and run them as module
   When destroy, must run `kops delete cluster` due to TF templates don't contain resources that are created dynamically (e.g: route53 entries)
   ```
   # apply
   tf apply -var-file=../01_init/tfvars.output

   # destroy
   tf destroy -var-file=../01_init/tfvars.output
   kops delete cluster
   ```
1. `03_jumphost`: Create a jumphost, populate private key and kube config to home folder
   ```
   tf apply -var-file=../02_kops/tfvars.output
   ```
