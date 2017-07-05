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
      "arn:aws:s3:::${var.KopsBucketNamePrefix}-${random_id.s3-postfix.hex}",
      "arn:aws:s3:::${var.KopsBucketNamePrefix}-${random_id.s3-postfix.hex}/*",
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "k8s-binaries-repository" {
  statement {
    sid = "Access-to-k8s-binaries-repository"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.BinariesRepositoryBucketNamePrefix}-${random_id.s3-postfix.hex}",
      "arn:aws:s3:::${var.BinariesRepositoryBucketNamePrefix}-${random_id.s3-postfix.hex}/*",
    ]
    principals {
      identifiers = ["*"]
      type = "AWS"
    }
  }
}

data "aws_iam_policy_document" "kops-jumphost" {
  statement {
    sid = "Access-for-kops-jumphost"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::${var.KopsBucketNamePrefix}-${random_id.s3-postfix.hex}",
      "arn:aws:s3:::${var.KopsBucketNamePrefix}-${random_id.s3-postfix.hex}/*",
      "arn:aws:s3:::${var.BinariesRepositoryBucketNamePrefix}-${random_id.s3-postfix.hex}",
      "arn:aws:s3:::${var.BinariesRepositoryBucketNamePrefix}-${random_id.s3-postfix.hex}/*",
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

data "external" "Download-Kubectl" {
  program = ["sh",
    "./scripts/download.sh",
    "${var.K8sBinaries["kubectl.url"]}",
    "${var.K8sBinaries["kubectl.outputFile"]}"
  ]
}

data "template_file" "install_kops" {
  template = "${file("./scripts/tpl/install_kops.tpl.sh")}"
  vars {
    region = "${var.region}"
    bucket = "${aws_s3_bucket.k8s-binaries-repository.id}"
    kops = "${aws_s3_bucket_object.kops.key}"
    kubectl = "${aws_s3_bucket_object.kubectl.key}"
  }
}