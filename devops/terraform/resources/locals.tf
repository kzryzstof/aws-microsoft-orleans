locals {
  service_name = "AwsOrleans"
  product_name = "Prototypes"
  
  resources_name = {
    service_role_name = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}Role"
    app_runner_name = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}"
    
    dynamodb_tables = {
      clustering = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}OrleansClusterTable"
      data_grain = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}DataGrainStorage"
    }

    policies = {
      cluster_table = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}OrleansClusterPolicy"
      data_grain = "${local.service_name}${provider::string-functions::pascal_case(var.environment_name)}${var.environment_instance}}DataGrainPolicy"
    }
  }
  
  tags = {
    "service": local.service_name
    "environment": var.environment_name,
    "product": local.product_name
  }
}