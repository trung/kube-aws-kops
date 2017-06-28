output "Name" {
  value = "${var.Name}"
}

output "AZs" {
  value = "${join(",", data.aws_availability_zones.available.names)}"
}

output "StateBucket" {
  value = "${var.KopsBucketName}"
}

output "VPCId" {
  value = "${aws_vpc.kubernetes.id}"
}

output "Cidr" {
  value = "${var.VpcCidr}"
}

output "MyIP" {
  value = "${var.MyIP}"
}