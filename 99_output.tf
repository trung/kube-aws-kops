output "Name" {
  value = "${var.Name}"
}

output "AZs" {
  value = "${join(",", data.aws_availability_zones.available.names)}"
}

output "StateBucket" {
  value = "${var.KopsBucketName}"
}