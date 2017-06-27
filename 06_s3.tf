resource "aws_s3_bucket" "k8s-jpmchase-net-state-store" {
  bucket = "${var.KopsBucketName}"
  acl = "private"
  policy = "${data.aws_iam_policy_document.k8s-jpmchase-net-state-store.json}"

  tags  = "${var.CommonTags}"
}