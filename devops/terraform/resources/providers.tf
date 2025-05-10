terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}