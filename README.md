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
CMD="export AMI=$(tf output AMI)"; echo "${CMD}"; eval ${CMD}
rm -rf out/
kops create cluster ${NAME} \
 --dns private  \
 --topology private \
 --api-loadbalancer-type internal \
 --zones ${AZs} \
 --master-zones ${AZs} \
 --master-size t2.medium \
 --node-size t2.medium \
 --cloud aws \
 --cloud-labels "BuiltBy=trung,BuiltReason=Provisioning Kuberenetes in AWS using Kops" \
 --vpc ${VPC} \
 --network-cidr ${NETWORK_CIDR} \
 --networking calico \
 --state ${KOPS_STATE_STORE} \
 --admin-access ${NETWORK_CIDR} \
 --ssh-public-key ./kops-key.pub \
 --image ${AMI} \
 --target terraform
```

Create k8s cluster using the generated TF template
```bash
cd out/terraform
tf apply
```

**Note:** it will take sometimes for the cluster to stand up. Don't RUSH!!!

Validate
1. SSH to jump host
+  Create `~/.kube/config` with the content from the local machine
+  Run `kubectl get nodes` and see 3 nodes running

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

## Few notes
* `master` instance is also a `node`
* `etcd` is in the `master`
* When exposing a service of type `LoadBalancer`, a public-facing ELB is created