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