locals {
  service_name = "AwsOrleans"
  product_name = "Prototypes"
  
  environment_name = provider::string-functions::pascal_case(var.environment_name)
  
  resources_name = {
    service_role_name = "${local.service_name}${local.environment_name}${var.environment_instance}}Role"
    app_runner_name = "${local.service_name}${local.environment_name}${var.environment_instance}}"
    
    dynamodb_tables = {
      clustering = "${local.service_name}${local.environment_name}${var.environment_instance}}OrleansClusterTable"
      data_grain = "${local.service_name}${local.environment_name}${var.environment_instance}}DataGrainStorage"
    }

    policies = {
      # Policies do not support numbers: which means in case of disposable environment,
      # we might want to reuse the same policies.
      cluster_table = "${local.service_name}${local.environment_name}}OrleansClusterPolicy"
      data_grain = "${local.service_name}${local.environment_name}}DataGrainPolicy"
    }
  }
  
  tags = {
    "service": local.service_name
    "environment": var.environment_name,
    "product": local.product_name
  }
}