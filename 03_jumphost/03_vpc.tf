# public subnet that is used for an EC2 instance on which we use it as a jumphost
resource "aws_subnet" "kops-jumphost" {
  cidr_block        = "10.15.255.0/24"
  vpc_id            = "${var.VpcId}"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"

  tags = "${merge(var.CommonTags, map("Name", format("%s-jumphost-%s", var.Name, data.aws_availability_zones.available.names[0])))}"
}

resource "aws_default_route_table" "kops-jumphost" {
  default_route_table_id = "${var.VPC-DefaultRouteTableId}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${var.IGWId}"
  }

  tags = "${merge(var.CommonTags, map("Name", "K8s-kops-jumphost-DefaultRoute"))}"
}

resource "aws_route_table_association" "kubernetes" {
  route_table_id = "${aws_default_route_table.kops-jumphost.id}"
  subnet_id      = "${aws_subnet.kops-jumphost.id}"
}

# this allows EC2 to access S3 privately
resource "aws_vpc_endpoint" "s3-k8s-binaries-repository" {
  service_name = "com.amazonaws.${var.region}.s3"
  vpc_id       = "${var.VpcId}"
  policy       = "${data.aws_iam_policy_document.kops-jumphost.json}"
}

resource "aws_vpc_endpoint_route_table_association" "s3-kube-artifacts-repository" {
  route_table_id  = "${aws_default_route_table.kops-jumphost.id}"
  vpc_endpoint_id = "${aws_vpc_endpoint.s3-k8s-binaries-repository.id}"
}
