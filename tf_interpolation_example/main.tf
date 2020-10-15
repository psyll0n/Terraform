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

# Resources
# Objects managed by Terrafirn sych as VMs or S3 Buckets.
# Declaring a Resource tells Terraform that it should CREATE and manage 
# the Resource described. If the resource already exists, it must be imported 
# into Terraform's state. 

resource "aws_s3_bucket" "tfbucket1" {
    bucket = "${data.aws_caller_identity.current.account_id}tfbucket1"
}


# Data Sources 
# Objects NOT managed by Terraform.

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {
    state = "available"
}







