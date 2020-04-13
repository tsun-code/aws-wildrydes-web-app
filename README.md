# Build a Serverless Web Application
### with AWS Lambda, Amazon API Gateway, Amazon S3, Amazon DynamoDB, and Amazon Cognito

## Manual Setup

#### Follow the steps in the following link:

https://aws.amazon.com/getting-started/hands-on/build-serverless-web-app-lambda-apigateway-s3-dynamodb-cognito/

## Terraform Setup
### Implement infrastructure as code with terraform for setting up the whole infrastructure. It allows instant creation or termination of the resources needed for this project.

#### Update the region and unique_name in 'wildrydes-terraform/terraform.tfvars' file to your own values

#### **`terraform.tfvars`**
```
region      = "ap-southeast-1"
unique_name = "your-own-name"
```

#### Setup the resources with terraform

```
cd wildrydes-terraform
terraform init
...
...
terraform plan
...
...
terraform apply -auto-approve
...
...
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

invoke_url = https://xxxxxxxxx.execute-api.ap-southeast-1.amazonaws.com/prod
region = ap-southeast-1
user_pool_client_id = 2mvjjk90d1k3alrs5bae16b6tj
user_pool_id = ap-southeast-1_xxxxxxxxx
website_endpoint = wildrydes-firstname-lastname.s3-website-ap-southeast-1.amazonaws.com
```

#### Update the 'js/config.js' file under your S3 bucket with the output values after you have applied the terraform.


#### To terminate and remove all the resources, run:

```
terraform destroy
```