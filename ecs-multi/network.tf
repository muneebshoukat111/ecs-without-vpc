# Uses the DEFAULT VPC and its subnets. This file creates nothing.

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

locals {
  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default.ids
}
