resource "aws_dynamodb_table" "data_grain" {
  name           = local.resources_names.dynamodb_tables.data_grain
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "GrainReference"
  range_key      = "GrainType"

  attribute {
    name = "GrainReference"
    type = "S"
  }

  attribute {
    name = "GrainType"
    type = "S"
  }

  ttl {
    attribute_name = "TtlAttribute"
    enabled        = true
  }

  tags = local.tags
}