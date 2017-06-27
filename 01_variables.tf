variable "region" {
  default = "us-west-1"
}

variable "Name" {
  description = "DNS name"
}

variable "CommonTags" {
  type = "map"
  default = {
    builtBy = "trung"
    builtWith = "terraform"
    builtReason = "Provisioning Kubernetes in AWS"
  }
}

variable "VpcCidr" {
  default = "10.10.0.0/16"
}

variable "KmsKeyAlias" {
  default = "trung-key"
}

variable "MyIP" {
  description = "CIDR block to limit only to my IP"
}

variable "KeyPairName" {
  default = "trung-ec2-key"
}

variable "KopsBucketName" {
  default = "k8s-jpmchase-net-state-store"
}