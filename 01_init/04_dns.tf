resource "aws_route53_zone" "kubernetes" {
  name = "${var.Name}"
  vpc_id = "${aws_vpc.kubernetes.id}"
  vpc_region = "${var.region}"

  tags = "${var.CommonTags}"
}