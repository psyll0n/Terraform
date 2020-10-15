# Configure the AWS Provider
provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "eu-central-1"
}

# Create a web server 
resource "aws_instance" "web" {
    # ...
}