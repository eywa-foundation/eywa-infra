provider "aws" {
  region  = "ap-northeast-2"
  profile = "jaehong21"
}
provider "cloudflare" {
  api_token = var.cloudflare_api_token
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    # S3 bucket name of .tfstate
    bucket = "eywa-tfstate"
    # tfstate path in S3
    key    = "terraform.tfstate"
    region = "ap-northeast-2"
    # name of dynamodb_table
    # dynamodb_table = "eywa-tfstate-lock"
    # aws-cli profile
    profile = "jaehong21"
  }
}

# resource "aws_s3_bucket" "tfstate_bucket" {
#   bucket = "eywa-tfstate"
# }
# resource "aws_s3_bucket_versioning" "tfstate_versioning" {
#   bucket = aws_s3_bucket.tfstate_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# resource "aws_dynamodb_table" "terraform_state_lock" {
#   name         = "eywa-tfstate-lock"
#   hash_key     = "LockID"
#   billing_mode = "PAY_PER_REQUEST"

#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }
