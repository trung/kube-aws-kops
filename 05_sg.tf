/*
resource "aws_security_group" "common" {
  vpc_id = "${aws_vpc.kubernetes.id}"

  tags = "${merge(var.CommonTags, map("Name", "Kubernetes-common"))}"
}
*/
resource "aws_security_group" "ssh" {
  vpc_id = "${aws_vpc.kubernetes.id}"

  # ssh
  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["${var.MyIP}"]
  }

  # ping
  ingress {
    from_port = 8
    protocol = "ICMP"
    to_port = -1
    cidr_blocks = ["${var.MyIP}"]
  }

  tags = "${merge(var.CommonTags, map("Name", "Kubernetes-debug"))}"
}