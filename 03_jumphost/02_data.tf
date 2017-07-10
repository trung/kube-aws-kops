data "aws_availability_zones" "available" {

}

data "aws_vpc" "kubernetes" {
  id = "${var.VpcId}"
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
      "arn:aws:s3:::${var.StateStore}",
      "arn:aws:s3:::${var.StateStore}/*",
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
    "${path.module}/scripts/download.sh",
    "${var.K8sBinaries["kops.url"]}",
    "${format("%s/%s", path.module, var.K8sBinaries["kops.outputFile"])}"
  ]
}

data "external" "Download-Kubectl" {
  program = ["sh",
    "${path.module}/scripts/download.sh",
    "${var.K8sBinaries["kubectl.url"]}",
    "${format("%s/%s", path.module, var.K8sBinaries["kubectl.outputFile"])}"
  ]
}

data "template_file" "install_kops" {
  template = "${file(format("%s/scripts/tpl/install_kops.tpl.sh", path.module))}"
  vars {
    region = "${var.region}"
    bucket = "${aws_s3_bucket.k8s-binaries-repository.id}"
    kops = "${aws_s3_bucket_object.kops.key}"
    kubectl = "${aws_s3_bucket_object.kubectl.key}"
    privatekey = "${file(var.JumpHostPrivateKey)}"
    kubeconfig = "${file(var.KubeConfig)}"
  }
}