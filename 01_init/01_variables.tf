variable "region" {
  default = "eu-central-1"
}

variable "Name" {
  description = "Cluster name"
}

variable "CommonTags" {
  type = "map"

  default = {
    BuiltBy     = "trung"
    BuiltWith   = "terraform"
    BuiltReason = "Provisioning Kubernetes in AWS using Kops"
  }
}

variable "VpcCidr" {
  default = "10.15.0.0/16"
}

variable "KopsBucketNamePrefix" {
  default = "k8s-jpmchase-net-state-store"
}

variable "AvailableAMIs" {
  type = "map"

  default = {
    us-west-1    = "ami-9fe6c7ff"
    us-west-2    = "ami-45224425"
    eu-central-1 = "ami-a74c95c8"
  }
}
