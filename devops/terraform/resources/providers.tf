terraform {
  backend "s3" {}

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    string-functions = {
      source = "registry.terraform.io/random-things/string-functions"
      version = ">= 1.8.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "string-functions" {}
