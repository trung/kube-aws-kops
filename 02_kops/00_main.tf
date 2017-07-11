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
    "s3://${var.StateStore}",
    "${var.AMI}",
    "${path.module}/kops-key.pub"
  ]
}

module "kops_tf" {
  source = "./out/terraform"
  dummy = "${}"
}

data "external" "DeleteGeneratedTerraform" {
  program = [
    "rm",
    "-rf",
    "${path.module}/out/terraform/data",
    "${module.kops_tf.dummy}"
  ]
  depends_on = ["data.external.RunKops"]
}

output "KubeConfigPath" {
  value = "~/.kube/config"
}