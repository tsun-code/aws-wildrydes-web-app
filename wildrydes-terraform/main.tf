provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

locals {
  bucket_name           = "wildrydes-tsun-code"
}

resource "aws_s3_bucket" "wildrydes" {
  region = var.region
  bucket = local.bucket_name

  versioning {
    enabled    = true
    mfa_delete = false
  }

  website {
    index_document = "index.html"
  }

  provisioner "local-exec" {
    command = "aws s3 sync s3://wildrydes-us-east-1/WebApplication/1_StaticWebHosting/website s3://${aws_s3_bucket.wildrydes.bucket} --region ${var.region}"
  }
}

resource "aws_s3_bucket_policy" "wildrydes" {
  bucket = aws_s3_bucket.wildrydes.id

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow", 
            "Principal": "*", 
            "Action": "s3:GetObject", 
            "Resource": "arn:aws:s3:::${local.bucket_name}/*" 
        } 
    ] 
}
POLICY
}

