variable "region" {
  default = "eu-central-1"
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
  type = "map"
  default = {
    us-west-1 = "ami-9fe6c7ff"
    us-west-2 = "ami-45224425"
    eu-central-1 = "ami-a74c95c8"
  }
}

variable "JumpHostInstanceType" {
  default = "t2.micro"
}

variable "VpcCidr" {
  default = "10.10.0.0/16"
}

variable "KmsKeyAlias" {
  default = "trung-key"
  description = "This key is used for encryption"
}

variable "MyIP" {
  description = "CIDR block to limit only to my IP"
}

variable "KeyPairName" {
  default = "trung-ec2-key"
  description = "This key is used for SSH"
}

variable "KopsBucketName" {
  default = "k8s-jpmchase-net-state-store"
}

variable "BinariesRepositoryBucketName" {
  default = "k8s-binaries-repository"
}

variable "K8sBinaries" {
  type = "map"
  default = {
    kops.url = "https://github.com/kubernetes/kops/releases/download/1.6.2/kops-linux-amd64"
    kops.outputFile = "./bin/kops"
    kubectl.url = "https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl"
    kubectl.outputFile = "./bin/kubectl"
  }
}