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
    auto_deployments_enabled = false
  }
  
  tags = local.tags
}

resource "aws_apprunner_auto_scaling_configuration_version" "auto" {
  auto_scaling_configuration_name = "default_scaling"
  min_size = 1
  max_size = 1
}

resource "aws_apprunner_default_auto_scaling_configuration_version" "default" {
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto.arn
}