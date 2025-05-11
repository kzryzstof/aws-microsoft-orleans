locals {
  service_name = "aws-orleans"
  product_name = "Prototypes"
  
  environment = provider::string-functions::pascal_case(var.environment_name)

  resources_names = {
    resource_group = "rg-${replace("-", "", provider::string-functions::pascal_case(local.service_name))}-${var.environment_name}-${var.environment_instance}"
    service_role = "${local.service_name}${local.environment}${var.environment_instance}}Role"
    app_runner = "${local.service_name}${local.environment}${var.environment_instance}}"
    
    dynamodb_tables = {
      cluster = "${local.service_name}${local.environment}${var.environment_instance}OrleansClusterTable"
      data_grain = "${local.service_name}${local.environment}${var.environment_instance}DataGrainStorage"
    }

    policies = {
      # Policies do not support numbers: which means in case of disposable environment,
      # we might want to reuse the same policies.
      cluster = "${local.service_name}${local.environment}OrleansClusterPolicy"
      data_grain = "${local.service_name}${local.environment}DataGrainPolicy"
    }
  }
  
  tags = {
    "service": local.service_name
    "environment": var.environment_name,
    "product": local.product_name
  }
}