resource "local_file" "tfvars-output" {
  content = <<EOF
Name="${var.Name}"
AMI="${lookup(var.AvailableAMIs, var.region)}"
AZs="${join(",", data.aws_availability_zones.available.names)}"
VPC_CIDR="${var.VpcCidr}"
StateStore="${aws_s3_bucket.k8s-jpmchase-net-state-store.id}"
VPCId="${aws_vpc.kubernetes.id}"
IGWId="${aws_internet_gateway.kubernetes.id}"
VPC_DefaultRouteTableId="${aws_vpc.kubernetes.default_route_table_id}"
EOF
  filename = "${path.module}/tfvars.output"
}

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