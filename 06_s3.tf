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

resource "aws_s3_bucket" "k8s-binaries-repository" {
  bucket = "${var.BinariesRepositoryBucketNamePrefix}-${random_id.s3-postfix.hex}"
  acl = "private"
  region = "${var.region}"
  policy = "${data.aws_iam_policy_document.k8s-binaries-repository.json}"

  tags  = "${var.CommonTags}"
}

resource "aws_s3_bucket_object" "kops" {
  bucket = "${aws_s3_bucket.k8s-binaries-repository.bucket}"
  key = "kops"

  # FIXME not able to find out a way to get the object with SSE
  # kms_key_id = "${data.aws_kms_alias.KmsKey.arn}"

  source = "${var.K8sBinaries["kops.outputFile"]}"
  content_type = "application/octet-stream"
  depends_on = ["data.external.Download-Kops"]

  tags = "${var.CommonTags}"
}

resource "aws_s3_bucket_object" "kubectl" {
  bucket = "${aws_s3_bucket.k8s-binaries-repository.bucket}"
  key = "kubectl"

  # FIXME not able to find out a way to get the object with SSE
  # kms_key_id = "${data.aws_kms_alias.KmsKey.arn}"

  source = "${var.K8sBinaries["kubectl.outputFile"]}"
  content_type = "application/octet-stream"
  depends_on = ["data.external.Download-Kubectl"]

  tags = "${var.CommonTags}"
}
