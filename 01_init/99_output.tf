output "Name" {
  value = "${var.Name}"
}

output "VPCId" {
  value = "${aws_vpc.kubernetes.id}"
}

output "VPC-DefaultRouteTableId" {
  value = "${aws_vpc.kubernetes.default_route_table_id}"
}

output "Cidr" {
  value = "${var.VpcCidr}"
}

output "StateBucket" {
  value = "${aws_s3_bucket.k8s-jpmchase-net-state-store.id}"
}

output "AZs" {
  value = "${join(",", data.aws_availability_zones.available.names)}"
}

output "AMI" {
  value = "${lookup(var.AvailableAMIs, var.region)}"
}

output "IGWId" {
  value = "${aws_internet_gateway.kubernetes.id}"
}