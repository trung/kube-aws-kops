terraform {
  backend "s3" {
    profile = "lab"
    region = "eu-central-1"

    bucket = "tf-state-store-dev"
    key = "kube-aws-kops/02_kops/terraform.state"
    dynamodb_table = "tf-lock"
  }
}

variable "Name" {
}
variable "AZs" {
}
variable "VPCId" {
}
variable "VPC_CIDR" {
}
variable "StateStore" {
}
variable "AMI" {
}
variable "AWSProfile" {
  default = "lab"
}

variable "IGWId" {

}

variable "VPC_DefaultRouteTableId" {
}

variable "MasterInstanceType" {
  default = "t2.medium"
}

variable "NodeInstanceType" {
  default = "t2.medium"
}

data "external" "RunKops" {
  program = [
    "sh",
    "${path.module}/scripts/kops.sh",
    "${var.Name}",
    "${var.AZs}",
    "${var.VPCId}",
    "${var.VPC_CIDR}",
    "s3://${var.StateStore}",
    "${var.AMI}",
    "${path.module}/kops-key.pub",
    "${var.AWSProfile}",
    "${var.MasterInstanceType}",
    "${var.NodeInstanceType}"
  ]
}

provider "aws" {
  region = "eu-central-1"
  profile = "lab"
}

module "kops_tf" {
  source = "./out/terraform"
  dummy = "${data.external.RunKops.id}"
}

resource "local_file" "tfvars-output" {
  content = <<EOF
KubeConfig="~/.kube/config"
IGWId="${var.IGWId}"
Name="${var.Name}"
StateStore="${var.StateStore}"
VPC-DefaultRouteTableId="${var.VPC_DefaultRouteTableId}"
VpcId="${var.VPCId}"
EOF
  filename = "${path.module}/tfvars.output"
}

output "KubeConfigPath" {
  value = "~/.kube/config"
}
