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