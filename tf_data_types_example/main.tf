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




# Terraform supports simple and complex data types.
 
locals {
    a_string  = "This is a string."
    a_number  = 3.1415
    a_boolean = true
    a_list    = [
        "element1",
        2,
        "three"
    ]
}

/*

a_map = {
    key = "value"
}

# Complex data type
person = {
    name = "Robert Jordan",
    phone_numbers = {
        home      = "415-444-1212"
        mobile    = "415-555-1313"
    },
    active = false,
    age    = 32
}

output "home_phone" {
    value = local.person.phone_numbers.home
}

*/

# Operators
# Terraform supports arithmetic and logical operations in expressions too. 

locals {
    //Arithmetic
    three = 1 + 2 // addition 
    two   = 3 - 1 // subtraction 
    one   = 2 / 2 // division 
    zero  = 1 * 0 // multiplication

    //Logical 
    t = true || false // OR true if either value is true.
    f = true && false // AND true if both values are true.

    //Comparision 
    gt  = 2 > 1   // true if left value is greater.
    gte = 2 >= 1  // true if left value is greater or equal.
    lt  = 1 < 2   // true if right value is greater.
    lte = 1 <= 2  // true if right value is greater or equal.
    eq  = 1 == 1  // true if left and right values are equal. 
    neq = 1 != 2  // true if left and right are not equal. 
}

output "arithmetic" {
    value = "${local.zero} ${local.one} ${local.two} ${local.three}"
}

output "logical" {
    value = "${local.t} ${local.f}"
}

output "comparision" {
    value = "${local.gt} ${local.gte} ${local.lt} ${local.lte} ${local.eq} ${local.neq}"
}


# Conditionals - If - Then statements
variable "bucket_count" {
    type = number
}

locals {
    minimum_number_of_buckets = 5
    number_of_buckets = var.bucket_count > 0 ? var.bucket_count : local.minimum_number_of_buckets // BUGGY !!!
}

# Local Values
# Local values allow you to assign a name to an expression. Locals can make your 
# code more readable. 

locals {
    aws_account = "${data.aws_caller_identity.current.account_id}-${lower(data.aws_caller_identity.current.user_id)}"
}


resource "aws_s3_bucket" "bucket-x" {
    count  = local.number_of_buckets
    bucket = "${local.aws_account}-bucket-x${count.index+7}"
}


# Functions
# Terraform has 100+ built in functions (but no ability to define custom functions!)
# https://wwww.terraform.io/docs/configurations.html
# The syntax for a function call is <function_name>(<arg1>, <arg2>).
