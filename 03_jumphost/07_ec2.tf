resource "aws_instance" "kops-jumphost" {
  ami                         = "${lookup(var.JumpHostAMI, var.region)}"
  instance_type               = "${var.JumpHostInstanceType}"
  vpc_security_group_ids      = ["${aws_security_group.common.id}", "${aws_security_group.ssh.id}"]
  subnet_id                   = "${aws_subnet.kops-jumphost.id}"
  key_name                    = "${var.KeyPairName}"
  associate_public_ip_address = true
  iam_instance_profile        = "s3_read_only"

  user_data = "${data.template_file.install_kops.rendered}"

  tags = "${merge(var.CommonTags, map("Name", format("%s-jumphost", var.Name)))}"
}
