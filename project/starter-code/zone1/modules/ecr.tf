terraform {
  required_version = ">= 1.0.2"

  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = ">= 3.50.0"
      configuration_aliases = [ aws.usw1 ]
    }
  }
}

resource "aws_ecr_repository" "select_region" {
  name                 = "us-west-1"
  image_tag_mutability = "MUTABLE"
}