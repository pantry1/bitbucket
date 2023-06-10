# Define the provider and region
provider "aws" {
  region  = var.region
  profile = var.profile
}

data "aws_availability_zones" "available" {}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}
