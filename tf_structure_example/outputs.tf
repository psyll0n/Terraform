
# Outputs
# Outputs are also used in more advanced use cases: modules, remote_states
# Outputs can be retrieved at any time by running the command 'terraform output'.

output "bucket_info" {
    value = aws_s3_bucket.terraform-test-bucket1
}

output "aws_caller_info" {
    value = data.aws_caller_identity.current
}

output "aws_availability_zones" {
    value = data.aws_availability_zones.available
}
