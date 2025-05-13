//  --------------------------------------------------------------------------------------------------------------------
//  App Runner resource
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_apprunner_service" "default" {
  service_name = local.resources_names.app_runner

  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto.arn

  source_configuration {
    
    image_repository {

      image_configuration {
        port = "8080"

        # This is where you define environment variables
        runtime_environment_variables = {
          OrleansConfiguration__ClusterId            = local.orleans.cluster_id
          OrleansConfiguration__ServiceId            = local.orleans.service_id
          OrleansConfiguration__Region               = var.region
          OrleansConfiguration__ClusteringTableName  = aws_dynamodb_table.orleans_cluster.name
          OrleansConfiguration__DataGrainTableName   = aws_dynamodb_table.data_grain.name
        }
      }
      
      image_identifier      = var.image_tag
      image_repository_type = "ECR"
    }

    authentication_configuration {
      access_role_arn = aws_iam_role.deployment_role.arn
    }

    auto_deployments_enabled = false
  }

  instance_configuration {
    instance_role_arn = aws_iam_role.service_role.arn
  }
  
  tags = local.tags
}

//  --------------------------------------------------------------------------------------------------------------------
//  Scaling.
//  --------------------------------------------------------------------------------------------------------------------
resource "aws_apprunner_auto_scaling_configuration_version" "auto" {
  auto_scaling_configuration_name = "default_scaling"
  min_size = 3
  max_size = 5
}

resource "aws_apprunner_default_auto_scaling_configuration_version" "default" {
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.auto.arn
}