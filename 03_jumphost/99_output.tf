output "JumpHost" {
  value = "${format("ssh -o \"UserKnownHostsFile=/dev/null\" -o \"StrictHostKeyChecking=no\" -i %s-%s.pem ubuntu@%s", var.KeyPairName, var.region, aws_instance.kops-jumphost.public_ip)}"
}