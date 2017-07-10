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

data "external" "RunKops" {
  program = [
    "sh",
    "${path.module}/scripts/kops.sh",
    "${var.Name}",
    "${var.AZs}",
    "${var.VPCId}",
    "${var.VPC_CIDR}",
    "${var.StateStore}",
    "${var.AMI}"
  ]
}

module "kops_tf" {
  source = "./out/terraform"
  dummy = "${data.external.RunKops.id}"
}

output "KubeConfigPath" {
  value = "~/.kube/config"
}