resource "aws_dynamodb_table" "weather_grain" {
  name           = "WeatherGrainTable"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "GrainIdN"
  range_key      = "GrainTypeString"

  attribute {
    name = "GrainIdN"
    type = "S"
  }

  attribute {
    name = "GrainTypeString"
    type = "S"
  }

  # Optional but recommended for performance
  attribute {
    name = "GrainIdS"
    type = "S"  # String type
  }

  global_secondary_index {
    name               = "GrainIdSIndex"
    hash_key           = "GrainIdS"
    range_key          = "GrainTypeString"
    projection_type    = "ALL"
    write_capacity     = 5
    read_capacity      = 5
  }

  ttl {
    attribute_name = "TtlAttribute"
    enabled        = true
  }

  tags = local.tags
}