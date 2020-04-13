output "user_pool_id" {
  value = aws_cognito_user_pool.wildrydes.id
}

output "user_pool_client_id" {
  value = aws_cognito_user_pool_client.wildrydes.id
}

output "region" {
  value = var.region
}

output "invoke_url" {
  value = aws_api_gateway_stage.wildrydes_prod.invoke_url
}

output "website_endpoint" {
  value = aws_s3_bucket.wildrydes.website_endpoint
}
