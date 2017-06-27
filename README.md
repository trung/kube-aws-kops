# kube-aws-kops
Kubernetes cluster in AWS using Kops and Terraform


```bash
export AWS_PROFILE=lab
export NAME=$(tf show -no-color | grep ^Name | awk -F'=' '{print $2}' | xargs)
export KOPS_STATE_STORE=s3://$(tf show -no-color | grep ^StateBucket | awk -F'=' '{print $2}' | xargs)
export AZs=$(tf show -no-color | grep ^AZs | awk -F'=' '{print $2}' | xargs)
export VPC=$(tf show -no-color | grep ^VPCId | awk -F'=' '{print $2}' | xargs)
export NETWORK_CIDR=$(tf show -no-color | grep ^Cidr | awk -F'=' '{print $2}' | xargs)
kops create cluster ${NAME} \
 --dns private  \
 --zones ${AZs} \
 --cloud aws \
 --vpc ${VPC} \
 --network-cidr ${NETWORK_CIDR} \
 --state ${KOPS_STATE_STORE}
```