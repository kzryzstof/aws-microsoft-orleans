resource "aws_resourcegroups_group" "default" {
  name  = local.resources_names.resource_group

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