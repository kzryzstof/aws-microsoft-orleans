locals {
  service_name = "OrleansApp"
  product_name = "Prototypes"
  
  environment = provider::string-functions::pascal_case(var.environment_name)

  resources_names = {
    resource_group = "${local.service_name}${local.environment}${var.environment_instance}"
    service_role = "${local.service_name}${local.environment}${var.environment_instance}Role"
    app_runner = "${local.service_name}${local.environment}${var.environment_instance}"
    
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
  
  orleans = {
    cluster_id = "aws-orleans"
    service_id = "aws-orleans"
  }
  
  tags = {
    "service": local.service_name
    "environment": var.environment_name,
    "product": local.product_name
  }
}