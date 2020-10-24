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



# Local Values
# Local values allow you to assign a name to an expression. Locals can make your 
# code more readable. 

locals {
    aws_account = "${data.aws_caller_identity.current.account_id}-${lower(data.aws_caller_identity.current.user_id)}"
}


# Count 
# All resources have a 'count' parameter. The default is 1. 
# If count is set then a list of resources is returned (even if there is only 1).
# If 'count' is set, then a 'count.index' value is available. The value contains 
# the current iteration number. 
# TIP: setting 'count = 0' is a handy way to remove a resource but keep the config. 

resource "aws_s3_bucket" "bucketX" {
    count = 0 
    bucket = "${local.aws_account}-bucket${count.index+7}"
}

# 'for_each' 
# Resources may have a 'for_each' parameter. 
# If 'for_each' is set then a resource is created for each item in the set and a
# special 'each' object is available. The 'each' object has 'key' and 'value'
# attributes that can be referenced. 

locals {
    buckets = {
        bucket101 = "mybucket101"
        bucket102 = "mybucket102"   }
}

resource "aws_s3_bucket" bucketE {
    for_each = local.buckets
    bucket   = "${local.aws_account}-${each.value}"
}


