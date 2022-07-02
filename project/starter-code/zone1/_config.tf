terraform {
  required_version = ">= 1.0.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }
  

   backend "s3" {
     bucket = "udacity-tf-project2"
     key    = "terraform/terraform.tfstate"
     region = "us-east-2"
   }
 }

provider "aws" {
  region = "us-east-2"
  
  default_tags {
    tags = local.tags
  }
}

provider "aws" {
  alias  = "usw1"
  region = "us-west-1"
}