provider "aws" {
  version = "~> 2.0"
  region  = var.region
}

locals {
  bucket_name           = "wildrydes-tsun-code"
  user_pool_name        = "WildRydes"
  user_pool_client_name = "WildRydesWebApp"
  dynamodb_table_name = "Rides"
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

resource "aws_cognito_user_pool" "wildrydes" {
  name                     = local.user_pool_name
  auto_verified_attributes = ["email"]

  username_configuration {
    case_sensitive = false
  }

  email_configuration {
    email_sending_account = "COGNITO_DEFAULT"
  }

  schema {
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    name                     = "email"
    required                 = true

    string_attribute_constraints {
      max_length = "2048"
      min_length = "0"
    }
  }

  password_policy {
    minimum_length                   = 8
    require_lowercase                = true
    require_numbers                  = true
    require_symbols                  = true
    require_uppercase                = true
    temporary_password_validity_days = 7
  }
}

resource "aws_cognito_user_pool_client" "wildrydes" {
  name = local.user_pool_client_name

  user_pool_id = aws_cognito_user_pool.wildrydes.id

  allowed_oauth_flows                  = []
  allowed_oauth_flows_user_pool_client = false
  allowed_oauth_scopes                 = []
  callback_urls                        = []
  logout_urls                          = []
  supported_identity_providers         = []
  refresh_token_validity               = "30"
  explicit_auth_flows                  = ["ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]

  read_attributes = [
    "address",
    "birthdate",
    "email",
    "email_verified",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "phone_number_verified",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]


  write_attributes = [
    "address",
    "birthdate",
    "email",
    "family_name",
    "gender",
    "given_name",
    "locale",
    "middle_name",
    "name",
    "nickname",
    "phone_number",
    "picture",
    "preferred_username",
    "profile",
    "updated_at",
    "website",
    "zoneinfo",
  ]

}

resource "aws_dynamodb_table" "wildrydes" {
  name           = local.dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "RideId"

  attribute {
    name = "RideId"
    type = "S"
  }
  
}