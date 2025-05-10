resource "aws_apprunner_service" "default" {
  service_name = local.service_name

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