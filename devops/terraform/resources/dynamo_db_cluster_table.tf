resource "aws_dynamodb_table" "orleans_cluster" {
  name           = local.resources_names.dynamodb_tables.cluster
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "DeploymentId"
  range_key      = "SiloIdentity"

  attribute {
    name = "DeploymentId"
    type = "S"
  }

  attribute {
    name = "SiloIdentity"
    type = "S"
  }

  ttl {
    attribute_name = "TtlAttribute"
    enabled        = true
  }

  tags = local.tags
}