resource "aws_vpc" "kubernetes" {
  cidr_block = "${var.VpcCidr}"
  enable_dns_hostnames = true

  tags = "${merge(var.CommonTags, map("Name", format("%s-vpc", var.Name)))}"
}