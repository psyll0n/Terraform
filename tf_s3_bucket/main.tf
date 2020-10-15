provider "aws" { 
    region = "eu-central-1"
}

resource "aws_s3_bucket" "terraform-test-bucket1" {
    bucket = "terraform-test-bucket1"
}

#Data Sources 
# Objects not managed by Terraform.

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}