# kube-aws-kops
Kubernetes cluster in AWS using Kops and Terraform


```bash
CMD="export AWS_PROFILE=lab"; echo $CMD; eval ${CMD}
CMD="export NAME=$(tf show -no-color | grep ^Name | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export KOPS_STATE_STORE=s3://$(tf show -no-color | grep ^StateBucket | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export AZs=$(tf show -no-color | grep ^AZs | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export VPC=$(tf show -no-color | grep ^VPCId | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export NETWORK_CIDR=$(tf show -no-color | grep ^Cidr | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export MY_IP_CIDR=$(tf show -no-color | grep ^MyIP | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
kops create cluster ${NAME} \
 --dns private  \
 --topology private \
 --zones ${AZs} \
 --cloud aws \
 --cloud-labels "BuiltBy=trung,BuiltReason=Provisioning Kuberenetes in AWS using Kops" \
 --vpc ${VPC} \
 --network-cidr ${NETWORK_CIDR} \
 --networking calico \
 --state ${KOPS_STATE_STORE} \
 --admin-access ${MY_IP_CIDR} \
 --ssh-public-key ./kops-key.pub \
 --image ami-9fe6c7ff \
 --target terraform
```

Findings:
1. `nodeup` installs packages and setups the OS:
   * `nodeup`: https://kubeupv2.s3.amazonaws.com/kops/1.6.1/linux/amd64/nodeup
   *
