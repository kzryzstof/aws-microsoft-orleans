//  --------------------------------------------------------------------------------------------------------------------
//  IAM Role
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_role" "app_runner_role" {
  name = "AwsOrleansRunnerRole"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "tasks.apprunner.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}

//  --------------------------------------------------------------------------------------------------------------------
//  App Runner resource
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_apprunner_service" "default" {
  service_name = local.service_name

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto.arn

  source_configuration {
    
    image_repository {

      image_configuration {
        port = "8080"
      }

      image_identifier      = var.image_tag
      image_repository_type = "ECR"
    }

    authentication_configuration {
      access_role_arn = aws_iam_role.app_runner_role.arn
    }
    
    auto_deployments_enabled = false
  }
  
  tags = local.tags
}

//  --------------------------------------------------------------------------------------------------------------------
//  Scaling.
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_apprunner_auto_scaling_configuration_version" "auto" {
  auto_scaling_configuration_name = "default_scaling"
  min_size = 1
  max_size = 1
}

resource "aws_apprunner_default_auto_scaling_configuration_version" "default" {
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto.arn
}

//  --------------------------------------------------------------------------------------------------------------------
//  App Runner permissions
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_iam_policy" "ecr_access" {
  name        = "app_runner_ecr_access_policy"
  description = "Policy to allow ECR access for App Runner role"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage"
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy_attachment" "app_runner" {
  role       = aws_iam_role.app_runner_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSAppRunnerServicePolicyForECRAccess"
}

resource "aws_iam_role_policy_attachment" "app_runner_ecr_access" {
  role       = aws_iam_role.app_runner_role.name
  policy_arn = aws_iam_policy.ecr_access.arn
}
