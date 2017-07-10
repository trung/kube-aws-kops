#!/bin/bash

tf apply
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
kops update cluster ${NAME} --yes