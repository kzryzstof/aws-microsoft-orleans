# Overview

This repository is a basic template of what is needed to setup an ASP.NET Web App running Orleans on AWS.

It contains the C# code as well as the Terraform IaC and the Azure DevOps pipeline needed to deploy the service
in an AWS App Runner instance connected to AWS DynamoDB to store the grains and silo information.

# Requirements

1. AWS account;
2. Azure DevOps account;
3. Service connection `AWS for Terraform` in DevOps configured with a User's `Access Key` and `Access Role`


# How to run locally

Install aws CLI:

`brew install awscli`

Validate the installation:

`aws --version`

Create a user with the proper permissions and then specify the Access ID & Access Key of that user:

`aws configure`
