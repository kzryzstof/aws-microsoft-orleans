terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    stringfunctions = {
      source  = "random-things/string-functions"
      version = "~> 0.1.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
