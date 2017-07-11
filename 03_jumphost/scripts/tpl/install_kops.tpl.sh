#!/bin/bash

kops_output_file="kops"
kubectl_output_file="kubectl"

pushd /tmp
mkdir kops
pushd kops
curl -s -L https://s3-${region}.amazonaws.com/${bucket}/${kops} --output $${kops_output_file}
chmod +x $${kops_output_file}
cp $${kops_output_file} /usr/local/bin/

curl -s -L https://s3-${region}.amazonaws.com/${bucket}/${kubectl} --output $${kubectl_output_file}
chmod +x $${kubectl_output_file}
cp $${kubectl_output_file} /usr/local/bin/

popd
rm -rf kops

pk="/home/ubuntu/.ssh/id_rsa"
echo "${privatekey}" >> $${pk}
chown ubuntu:ubuntu $${pk}
chmod 600 $${pk}

kube_conf_dir="/home/ubuntu/.kube"
mkdir $${kube_conf_dir}
echo "${kubeconfig}" > $${kube_conf_dir}/config
chown -R ubuntu:ubuntu $${kube_conf_dir}