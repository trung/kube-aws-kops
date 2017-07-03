# kube-aws-kops
Kubernetes private cluster in AWS using Kops and Terraform. **All access via a jumphost**

## Build

Initial setup
```bash
tf apply
```

Generate Terraform template
```bash
CMD="export AWS_PROFILE=lab"; echo $CMD; eval ${CMD}
CMD="export NAME=$(tf output Name)"; echo "${CMD}"; eval ${CMD}
CMD="export KOPS_STATE_STORE=s3://$(tf output StateBucket)"; echo "${CMD}"; eval ${CMD}
CMD="export AZs=$(tf output AZs)"; echo "${CMD}"; eval ${CMD}
CMD="export VPC=$(tf output VPCId)"; echo "${CMD}"; eval ${CMD}
CMD="export NETWORK_CIDR=$(tf output Cidr)"; echo "${CMD}"; eval ${CMD}
CMD="export MyIP=$(tf output MyIP)"; echo "${CMD}"; eval ${CMD}
kops create cluster ${NAME} \
 --dns private  \
 --topology private \
 --api-loadbalancer-type internal \
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

Create k8s cluster using the generated TF template
```bash
cd out/terraform
tf apply
```

## Destroy

Destroy k8s cluster
```bash
pushd out/terraform
tf destroy
popd
kops delete cluster ${NAME} --yes
```
OR simpler
```bash
kops delete cluster ${NAME} --yes
```

Destroy the initial infra
```bash
tf destroy
```

*Yay! It works!!*
