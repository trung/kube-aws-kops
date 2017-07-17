#!/bin/bash

kubectl_output_file="kubectl"

pushd /tmp
mkdir install
pushd install

curl -s -L https://s3-${region}.amazonaws.com/${bucket}/${kubectl} --output $${kubectl_output_file}
chmod +x $${kubectl_output_file}
cp $${kubectl_output_file} /usr/local/bin/

popd
rm -rf install

pk="/home/ubuntu/.ssh/id_rsa"
echo "${privatekey}" >> $${pk}
chown ubuntu:ubuntu $${pk}
chmod 600 $${pk}

kube_conf_dir="/home/ubuntu/.kube"
mkdir $${kube_conf_dir}
echo "${kubeconfig}" > $${kube_conf_dir}/config
chown -R ubuntu:ubuntu $${kube_conf_dir}