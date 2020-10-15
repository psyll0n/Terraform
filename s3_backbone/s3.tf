resource "aws_s3_bucket" "main" {
    bucket = "test-tf-private-bucket1"
    acl    = "private"

tags = {
    Name         = "My Bucket"
    Environment  = "Dev"
  }
}