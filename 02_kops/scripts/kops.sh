#!/bin/bash

NAME="$1"
AZs="$2"
VPC="$3"
NETWORK_CIDR="$4"
KOPS_STATE_STORE="$5"
AMI="$6"
SSH_PUBLIC_KEY="$7"
AWS_PROFILE="$8"
MASTER_INSTANCE_TYPE="$9"
NODE_INSTANCE_TYPE="${10}"

export AWS_PROFILE=${AWS_PROFILE}
kops create cluster ${NAME} \
 --dns private  \
 --topology private \
 --api-loadbalancer-type internal \
 --zones ${AZs} \
 --master-size ${MASTER_INSTANCE_TYPE} \
 --node-size ${NODE_INSTANCE_TYPE} \
 --cloud aws \
 --cloud-labels "BuiltBy=trung,BuiltReason=Provisioning Kuberenetes in AWS using Kops" \
 --vpc ${VPC} \
 --network-cidr ${NETWORK_CIDR} \
 --networking calico \
 --state ${KOPS_STATE_STORE} \
 --admin-access ${NETWORK_CIDR} \
 --ssh-public-key ${SSH_PUBLIC_KEY} \
 --image ${AMI} \
 --target terraform > kops_create.log 2>&1

kops_create_return="$?"

echo "{\"kops_create\" : \"${kops_create_return}\"}"