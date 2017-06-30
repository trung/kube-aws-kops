data "aws_kms_alias" "KmsKey" {
  name = "alias/${var.KmsKeyAlias}"
}

data "aws_availability_zones" "available" {

}

data "aws_iam_policy_document" "k8s-jpmchase-net-state-store" {
  statement {
    sid = "Access-to-k8s-jpmchase-net-state-store-for-kops-only"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.KopsBucketName}",
      "arn:aws:s3:::${var.KopsBucketName}/*",
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "k8s-binaries-repsitory" {
  statement {
    sid = "Access-to-k8s-binaries-repository"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.BinariesRepositoryBucketName}",
      "arn:aws:s3:::${var.BinariesRepositoryBucketName}/*",
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
  }
}

data "external" "Download-Kops" {
  program = ["sh",
    "./scripts/download.sh",
    "${var.K8sBinaries["kops.url"]}",
    "${var.K8sBinaries["kops.outputFile"]}"
  ]
}

data "template_file" "install_kops" {
  template = "${file("./scripts/tpl/install_kops.tpl.sh")}"
  vars {
    region = "${var.region}"
    bucket = "${aws_s3_bucket.k8s-binaries-repository.id}"
    object = "${aws_s3_bucket_object.kops.key}"
  }
}