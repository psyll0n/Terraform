# Terraform 
# Optional configfuration for the Terraform engine. 

terraform {
    required_version = ">=0.12.0"
}


# Provider
# Implement cloud specific API and Terraform API.
# Provider configuration is specific to each provider. 
# Providers expose Data Sources and Resources to Terraform. 

provider "aws" { 
    version = "~> 2.0"
    region  = "eu-central-1"
    #access_key = "my-access-key"
    #secret_key = "my-secret-key"


    # Many providers also accept configuration via environment variables
    # or config files. The AWS provider will read the standard AWS CLI
    # settings if they are present.  
}


# Data Sources 
# Objects NOT managed by Terraform.

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}


/* Dependency
Resources can depend on one another. Terraform will ensure that all dependencies
are met before creating the resource. Dependency can be implicit or explicit. */


resource "aws_s3_bucket" "tfbucket2" {
    bucket = "${data.aws_caller_identity.current.account_id}-tfbucket2"
}


resource "aws_s3_bucket" "tfbucket3" {
    bucket = "${data.aws_caller_identity.current.account_id}-tfbucket3"
    // Implicit Dependency  
    tags = {
        dependency = aws_s3_bucket.tfbucket2.arn
    }
}


resource "aws_s3_bucket" "tfbucket4" { 
    bucket = "${data.aws_caller_identity.current.account_id}-tfbucket4"
    // Explicit Dependency
    depends_on = [ 
        aws_s3_bucket.tfbucket3
    ]
}