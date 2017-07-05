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

output "JumpHost" {
  value = "${format("ssh -o \"UserKnownHostsFile=/dev/null\" -o \"StrictHostKeyChecking=no\" -i %s-%s.pem ubuntu@%s", var.KeyPairName, var.region, aws_instance.kops-jumphost.public_ip)}"
}

output "AMI" {
  value = "${lookup(var.JumpHostAMI, var.region)}"
}