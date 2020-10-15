// A single line
# comment
variable "ami" {
    description = "the AMI to use"
}

/* A multi
line comment. */
resource "aws_instance" "web" {
    ami                = "${var.ami}"
    count              = 2
    source_dest_check  = false 

    user_data = <<EOF
#!/bin/bash
echo "Hello, Terraform"
EOF
}

variable "zones" {
  type    = "list"
  default = ["eu-central-1"]
}