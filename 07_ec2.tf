resource "aws_instance" "kops-jumphost" {
  ami = "${var.JumpHostAMI}"
  instance_type = "${var.JumpHostInstanceType}"
  vpc_security_group_ids = ["${aws_security_group.ssh.id}"]
  subnet_id = "${aws_subnet.kops-jumphost.id}"
  key_name = "${var.KeyPairName}"
  associate_public_ip_address = true

  tags = "${merge(var.CommonTags, map("Name", "kops-jumphost"))}"
}