variable "region" {
  default = "us-west-1"
}

variable "Name" {
  description = "DNS name"
}

variable "CommonTags" {
  type = "map"
  default = {
    BuiltBy = "trung"
    BuiltWith = "terraform"
    BuiltReason = "Provisioning Kubernetes in AWS using Kops"
  }
}

variable "JumpHostAMI" {
  default = "ami-9fe6c7ff"  # us-west-1
}

variable "JumpHostInstanceType" {
  default = "t2.micro"
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