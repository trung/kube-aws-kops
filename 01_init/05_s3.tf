resource "random_id" "s3-postfix" {
  byte_length = 8
}

resource "aws_s3_bucket" "k8s-jpmchase-net-state-store" {
  bucket = "${var.KopsBucketNamePrefix}-${random_id.s3-postfix.hex}"
  acl = "private"
  region = "${var.region}"
  versioning = {
    enabled = true
  }
  force_destroy = true
  policy = "${data.aws_iam_policy_document.k8s-jpmchase-net-state-store.json}"

  tags  = "${var.CommonTags}"
}