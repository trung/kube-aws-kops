variable "region" {
  default = "eu-central-1"
}

variable "Name" {
  description = "Cluster name"
}

variable "CommonTags" {
  type = "map"
  default = {
    BuiltBy = "trung"
    BuiltWith = "terraform"
    BuiltReason = "Provisioning Kubernetes in AWS using Kops"
  }
}

variable "MyIP" {
  description = "CIDR block to limit only to my IP"
}

variable "JumpHostPrivateKey" {

}