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
    "${var.AWSProfile}"
  ]
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