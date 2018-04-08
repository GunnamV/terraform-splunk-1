variable "aws_region" {}
variable "aws_profile" {}
data "aws_availability_zones" "available" {}
variable "vpc_cidr" {}

variable "cidrs" {
  type = "map"
}
variable prod_instance_type {}
variable key_name {}
variable prod_ami {}
variable public_key_path {}

