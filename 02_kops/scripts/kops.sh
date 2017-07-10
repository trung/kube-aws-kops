#!/bin/bash

rm -rf out/terraform/data
rm -rf out/terraform/kubernetes.tf

NAME="$1"
AZs="$2"
VPC="$3"
NETWORK_CIDR="$4"
KOPS_STATE_STORE="$5"
AMI="$6"
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

echo "{}"