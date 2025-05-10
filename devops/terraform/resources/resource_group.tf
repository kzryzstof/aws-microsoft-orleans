module "resource_group_naming_convention" {
  source              = "../modules/naming_convention"
  environment         = var.environment_name
  name                = local.service_name
  type                = "rg"
  instance            = var.environment_instance
  delimiter           = "-"
}

resource "aws_resourcegroups_group" "default" {
  name  = module.resource_group_naming_convention.name

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "service",
      "Values": ["${local.service_name}"]
    },
    {
      "Key": "environment",
      "Values": ["${var.environment_name}"]
    },
    {
      "Key": "product",
      "Values": ["${local.product_name}"]
    }
  ]
}
JSON
  }
  
  tags  = local.tags
}