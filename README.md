# kube-aws-kops
Kubernetes cluster in AWS using Kops and Terraform


```bash
export NAME=$(tf show | grep ^Name | awk -F'=' '{print $2}' | xargs)
export KOPS_STATE_STORE=$(tf show | grep ^StateBucket | awk -F'=' '{print $2}' | xargs)
export AZs=$(tf show | grep ^AZs | awk -F'=' '{print $2}' | xargs)
kops create cluster ${NAME} \
 --dns private  \
 --zones ${AZs} \
 --state s3://${KOPS_STATE_STORE}
```