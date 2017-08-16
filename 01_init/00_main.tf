terraform {
  backend "s3" {
    profile = "lab"
    region  = "eu-central-1"

    bucket         = "tf-state-store-dev"
    key            = "kube-aws-kops/01_init/terraform.state"
    dynamodb_table = "tf-lock"
  }
}

provider "aws" {
  region  = "${var.region}"
  profile = "lab"
}
