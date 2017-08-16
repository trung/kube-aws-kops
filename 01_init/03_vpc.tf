resource "aws_vpc" "kubernetes" {
  cidr_block           = "${var.VpcCidr}"
  enable_dns_hostnames = true

  tags = "${merge(var.CommonTags, map("Name", format("%s-vpc", var.Name)))}"
}

resource "aws_internet_gateway" "kubernetes" {
  vpc_id = "${aws_vpc.kubernetes.id}"

  tags = "${merge(var.CommonTags, map("Name", format("%s-igw", var.Name)))}"
}
