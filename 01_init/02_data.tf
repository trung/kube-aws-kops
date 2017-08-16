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
      type        = "AWS"
    }
  }
}

data "aws_availability_zones" "available" {}
