# kube-aws-kops
Kubernetes private cluster in AWS using Kops and Terraform. **All access via a jumphost**


```bash
CMD="export AWS_PROFILE=lab"; echo $CMD; eval ${CMD}
CMD="export NAME=$(tf show -no-color | grep ^Name | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export KOPS_STATE_STORE=s3://$(tf show -no-color | grep ^StateBucket | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export AZs=$(tf show -no-color | grep ^AZs | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export VPC=$(tf show -no-color | grep ^VPCId | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
CMD="export NETWORK_CIDR=$(tf show -no-color | grep ^Cidr | awk -F'=' '{print $2}' | xargs)"; echo "${CMD}"; eval ${CMD}
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
 --admin-access ${NETWORK_CIDR} \
 --ssh-public-key ./kops-key.pub \
 --image ami-9fe6c7ff \
 --target terraform
```

**Note:**
+ Create jumphost separately with `kops` and `kubectl` installed
+ Jumphost must have outbound 443 so it can communicate with master
+ Need to add inbound 443 into master manually `kops` bug???
+ `~/.kube/config` setups `kube-apiserver` endpoint to the external DNS