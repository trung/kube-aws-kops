#!/bin/bash

output_file="kops"

pushd /tmp
mkdir kops
pushd kops
curl -s -L https://s3-${region}.amazonaws.com/${bucket}/${object} --output $${output_file}
chmod +x $${output_file}
cp $${output_file} /usr/local/bin/
popd
rm -rf kops