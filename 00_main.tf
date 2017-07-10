provider "aws" {
  region = "${var.region}"
  profile = "lab"
}

module "init" {
  source = "./01_init"
  Name = "${var.Name}"
  CommonTags = "${var.CommonTags}"
}

module "kops" {
  source = "./02_kops"
  AMI = "${module.init.AMI}"
  AZs = "${module.init.AZs}"
  Name = "${var.Name}"
  StateStore = "${module.init.StateBucket}"
  VPC_CIDR = "${module.init.Cidr}"
  VPCId = "${module.init.VPCId}"
}

module "jumphost" {
  source = "./03_jumphost"
  KubeConfig = "${module.kops.KubeConfigPath}"
  MyIP = "${var.MyIP}"
  Name = "${var.Name}"
  CommonTags = "${var.CommonTags}"
  StateStore = "${module.init.StateBucket}"
  VpcId = "${module.init.VPCId}"
  VPC-DefaultRouteTableId = "${module.init.VPC-DefaultRouteTableId}"
  JumpHostPrivateKey = "${var.JumpHostPrivateKey}"
}