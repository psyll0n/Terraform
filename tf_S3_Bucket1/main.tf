provider "aws" { 
    region = "eu-central-1"
}

resource "aws_s3_bucket" "bucket1" {
 
}


# Data Sources 
# Objects not managed by Terraform.

data "aws_caller_identity" "current" {

}

data "aws_availability_zones" "available" {
    state = "available"
}


# Outputs
# Outputs are printed by the CLI after 'apply'.
# These can reveal calculated values.aws_s3_bucket

output "bucket_info" {
    value = aws_s3_bucket.bucket1
}


output "aws_caller_info" {
    value = data.aws_caller_identity.current
}

output "aws_availability_zones" {
    value = data.aws_availability_zones.available
}





