# The default "aws" configuration is used for AWS resources in the root
# module where no explicit provider instance is selected.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.7.0"
      configuration_aliases = [ aws.usw1 ]
    }
  }
}

provider "aws" {
  region = "us-east-2"
  
  default_tags {
    tags = local.tags
  }
}

# An alternate configuration is also defined for a different
# region, using the alias "usw2".
provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}


locals {
   account_id = data.aws_caller_identity.current.account_id

   name   = "udacity"
   region = "us-east-2"
   tags = {
     Name      = local.name
     Terraform = "true"
   }
 }

 module "vpc" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"

   account_owner = local.name
   name          = "${local.name}-project"
   azs           = ["us-east-2a","us-east-2b"]
   private_subnet_tags = {
     "kubernetes.io/role/internal-elb" = 1
   }
   public_subnet_tags = {
     "kubernetes.io/role/elb" = 1
   }
 }

  module "vpc_west" {
   source     = "./modules/vpc"
   cidr_block = "10.100.0.0/16"

   account_owner = local.name
   name          = "${local.name}-project"
   azs           = ["us-west-1b","us-west-1a"]
   private_subnet_tags = {
     "kubernetes.io/role/internal-elb" = 1
   }
   public_subnet_tags = {
     "kubernetes.io/role/elb" = 1
   }
   providers = {
    aws = aws.usw1
   }
 }

output "vpc_id" {
   value = module.vpc_west.vpc_id
 }

 output "private_subnet_ids" {
   value = module.vpc_west.private_subnet_ids
 }

 output "public_subnet_ids" {
   value = module.vpc_west.public_subnet_ids
 }