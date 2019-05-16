output "website_endpoint" {
  description = "Region-specific DNS hostname of the bucket's webserver."
  value = "${aws_s3_bucket.website_bucket.website_endpoint}"
}

output "website_bucket_id" {
  description = "This is actually the bucket name. Discussion here - https://github.com/hashicorp/terraform/issues/9845"
  value = "${aws_s3_bucket.website_bucket.id}"
}
