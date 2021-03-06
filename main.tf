resource "random_string" "random" {
  length = 16
  special = false
  upper = false
}

resource "aws_s3_bucket" "website_bucket" {
  force_destroy = true
  bucket = "${var.bucket_name}-${random_string.random.result}"
  acl    = "public-read"
  
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "PUT", "POST", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = 3000
  }

  versioning {
    enabled = true
  }

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::${var.bucket_name}-${random_string.random.result}/*"
        }
    ]
}
POLICY


  tags = {
    owner = "jmartinson@hashicorp.com"
  }
}
