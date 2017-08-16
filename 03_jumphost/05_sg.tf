resource "aws_security_group" "common" {
  vpc_id = "${var.VpcId}"

  # S3 access
  egress {
    from_port   = 443
    protocol    = "TCP"
    to_port     = 443
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(var.CommonTags, map("Name", "K8s-common"))}"
}

resource "aws_security_group" "ssh" {
  vpc_id = "${var.VpcId}"

  # external ssh
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["${var.MyIP}"]
  }

  # ssh within VPC
  egress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["${data.aws_vpc.kubernetes.cidr_block}"]
  }

  # ping
  ingress {
    from_port   = 8
    protocol    = "ICMP"
    to_port     = -1
    cidr_blocks = ["${var.MyIP}"]
  }

  tags = "${merge(var.CommonTags, map("Name", "K8s-debug"))}"
}
