resource "aws_vpc" "kubernetes" {
  cidr_block = "${var.VpcCidr}"
  enable_dns_hostnames = true

  tags = "${merge(var.CommonTags, map("Name", "Kubernetes-VPC"))}"
}


resource "aws_internet_gateway" "kubernetes" {
  vpc_id = "${aws_vpc.kubernetes.id}"

  tags = "${merge(var.CommonTags, map("Name", "Kubernetes-GW"))}"
}

# public subnet that is used for an EC2 instance on which we use it as a jumphost
resource "aws_subnet" "kops-jumphost" {
  cidr_block = "10.10.10.10/30"
  vpc_id = "${aws_vpc.kubernetes.id}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = "${merge(var.CommonTags, map("Name", format("K8s-kops-jumphost-%s", data.aws_availability_zones.available.names[0])))}"
}

resource "aws_default_route_table" "kops-jumphost" {
  default_route_table_id = "${aws_vpc.kubernetes.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.kubernetes.id}"
  }

  tags = "${merge(var.CommonTags, map("Name", "K8s-kops-jumphost-DefaultRoute"))}"
}

resource "aws_route_table_association" "kubernetes" {
  route_table_id = "${aws_default_route_table.kops-jumphost.id}"
  subnet_id = "${aws_subnet.kops-jumphost.id}"
}